Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeEBXJH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:09:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751814AbeEBXIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:08:47 -0400
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 3/4] KEYS: Support for inserting a certificate into x86 bzImage
Date: Wed,  2 May 2018 19:08:10 -0400
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050223-0012-0000-0000-000016260F5E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008959; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026618; UDB=6.00524344; IPR=6.00805804;
 MB=3.00020894; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-02 23:08:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050223-0013-0000-0000-0000528EE207
Message-Id: <20180502230811.2751-4-mkayaalp@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config option SYSTEM_EXTRA_CERTIFICATE (introduced in c4c361059585)
reserves space in vmlinux file, which is compressed to create the
self-extracting bzImage. This patch adds the capability of extracting the
vmlinux, inserting the certificate, and repackaging the result into a
bzImage.

It only works if the resulting compressed vmlinux is smaller than the
original. Otherwise re-linking would be required. To make the reserved
space allocate actual space in bzImage, incompressible bytes are
inserted into the vmlinux as a placeholder for the extra certificate.
After receiving a bzImage that is created this way, the actual
certificate can be inserted into the bzImage:

	scripts/insert-sys-cert -s <System.map> -z <bzImage> -c <certfile>

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 257 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 252 insertions(+), 5 deletions(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 10a17504dc87..a3bd7ea8a436 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -7,7 +7,8 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: insert-sys-cert [-s <System.map> -b <vmlinux> -c <certfile>
+ * Usage: insert-sys-cert [-s <System.map>] -b <vmlinux> -c <certfile>
+ *                        [-s <System.map>] -z <bzImage> -c <certfile>
  */
 
 #define _GNU_SOURCE
@@ -370,6 +371,228 @@ static char *read_file(char *file_name, int *size)
 	return buf;
 }
 
+#define BOOT_FLAG		0xAA55
+#define MAGIC			0x53726448
+
+#define BOOT_FLAG_O		0x1FE
+#define MAGIC_O			0x202
+#define VERSION_O		0x206
+#define SETUP_SECTS_O		0x1F1
+#define PAYLOAD_OFFSET_O	0x248
+#define PAYLOAD_LENGTH_O	0x24C
+
+static int image_supported(char *bzimage, int bzimage_size)
+{
+	u16 boot_flag;
+	u32 magic;
+	u16 version;
+
+	if (bzimage_size < 1024) {
+		err("Invalid bzImage: File is too small\n");
+		return 0;
+	}
+
+	boot_flag = *((u16 *)&bzimage[BOOT_FLAG_O]);
+	magic = *((u32 *)&bzimage[MAGIC_O]);
+	version = *((u16 *)&bzimage[VERSION_O]);
+
+	if (boot_flag != BOOT_FLAG || magic != MAGIC) {
+		err("Invalid bzImage: Magic mismatch\n");
+		return 0;
+	}
+
+	if (version < 0x208) {
+		err("Invalid bzImage: Boot version <2.08 not supported\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static void get_payload_info(char *bzimage, int *offset, int *size)
+{
+	unsigned int system_offset;
+	unsigned char setup_sectors;
+
+	setup_sectors = bzimage[SETUP_SECTS_O] + 1;
+	system_offset = setup_sectors * 512;
+	*offset = system_offset + *((int *)&bzimage[PAYLOAD_OFFSET_O]);
+	*size = *((int *)&bzimage[PAYLOAD_LENGTH_O]);
+}
+
+static void update_payload_info(char *bzimage, int new_size)
+{
+	int offset, size;
+
+	get_payload_info(bzimage, &offset, &size);
+	*((int *)&bzimage[PAYLOAD_LENGTH_O]) = new_size;
+	if (new_size < size)
+		memset(bzimage + offset + new_size, 0, size - new_size);
+}
+
+struct zipper {
+	unsigned char pattern[10];
+	int length;
+	char *command;
+	char *compress;
+};
+
+struct zipper zippers[] = {
+	{{0x7F, 'E', 'L', 'F'},
+	 4, "cat", "cat"},
+	{{0x1F, 0x8B},
+	 2, "gunzip", "gzip -n -f -9"},
+	{{0xFD, '7', 'z', 'X', 'Z', 0},
+	 6, "unxz", "xz"},
+	{{'B', 'Z', 'h'},
+	 3, "bunzip2", "bzip2 -9"},
+	{{0xFF, 'L', 'Z', 'M', 'A', 0},
+	 6, "unlzma", "lzma -9"},
+	{{0xD3, 'L', 'Z', 'O', 0, '\r', '\n', 0x20, '\n'},
+	 9, "lzop -d", "lzop -9"}
+};
+
+static struct zipper *get_zipper(char *p)
+{
+	int i;
+
+	for (i = 0; i < sizeof(zippers) / sizeof(struct zipper); i++) {
+		if (memcmp(p, zippers[i].pattern, zippers[i].length) == 0)
+			return &zippers[i];
+	}
+	return NULL;
+}
+
+static u32 crc32(u32 seed, const char *buffer, int size)
+{
+	int i, j;
+	u32 byte, crc, mask;
+
+	crc = seed;
+	for (i = 0; i < size; i++) {
+		byte = buffer[i];
+		crc = crc ^ byte;
+		for (j = 7; j >= 0; j--) {
+			mask = -(crc & 1);
+			crc = (crc >> 1) ^ (0xEDB88320 & mask);
+		}
+	}
+	return crc;
+}
+
+/*
+ * This only works for x86 bzImage
+ */
+static void extract_vmlinux(char *bzimage, int bzimage_size,
+			    char **file, struct zipper **zipper)
+{
+	int r;
+	char src[15] = "vmlinux-XXXXXX";
+	char dest[15] = "vmlinux-XXXXXX";
+	char cmd[100];
+	int src_fd, dest_fd;
+	int offset, size;
+	struct zipper *z;
+
+	if (!image_supported(bzimage, bzimage_size))
+		return;
+
+	get_payload_info(bzimage, &offset, &size);
+	z = get_zipper(bzimage + offset);
+	if (!z) {
+		err("Unable to determine the compression of vmlinux\n");
+		return;
+	}
+
+	src_fd = mkstemp(src);
+	if (src_fd == -1) {
+		perror("Could not create temp file");
+		return;
+	}
+
+	r = write(src_fd, bzimage + offset, size);
+	if (r != size) {
+		perror("Could not write vmlinux");
+		return;
+	}
+	dest_fd = mkstemp(dest);
+	if (dest_fd == -1) {
+		perror("Could not create temp file");
+		return;
+	}
+
+	snprintf(cmd, sizeof(cmd), "%s <%s >%s", z->command, src, dest);
+	info("Executing: %s\n", cmd);
+	r = system(cmd);
+	if (r != 0)
+		warn("Possible errors when extracting\n");
+
+	r = remove(src);
+	if (r != 0)
+		perror(src);
+
+	*file = strdup(dest);
+	*zipper = z;
+}
+
+static void repack_image(char *bzimage, int bzimage_size,
+			 char *vmlinux_file, struct zipper *z)
+{
+	char tmp[15] = "vmlinux-XXXXXX";
+	char cmd[100];
+	int fd;
+	struct stat st;
+	int new_size;
+	int r;
+	int offset, size;
+	u32 *crc;
+
+	get_payload_info(bzimage, &offset, &size);
+
+	fd = mkstemp(tmp);
+	if (fd == -1) {
+		perror("Could not create temp file");
+		return;
+	}
+	snprintf(cmd, sizeof(cmd), "%s <%s >%s",
+		 z->compress, vmlinux_file, tmp);
+
+	info("Executing: %s\n", cmd);
+	r = system(cmd);
+	if (r != 0)
+		warn("Possible errors when compressing\n");
+
+	r = remove(vmlinux_file);
+	if (r != 0)
+		perror(vmlinux_file);
+
+	if (fstat(fd, &st)) {
+		perror("Could not determine file size");
+		close(fd);
+	}
+	new_size = st.st_size;
+	if (new_size > size) {
+		err("Increase in compressed size is not supported.\n");
+		err("Old size was %d, new size is %d\n", size, new_size);
+		exit(EXIT_FAILURE);
+	}
+
+	r = read(fd, bzimage + offset, new_size);
+	if (r != new_size)
+		perror(tmp);
+
+	r = remove(tmp);
+	if (r != 0)
+		perror(tmp);
+
+	/* x86 specific patching of bzimage */
+	update_payload_info(bzimage, new_size);
+
+	/* update CRC */
+	crc = (u32 *)(bzimage + bzimage_size - 4);
+	*crc = crc32(~0, bzimage, bzimage_size);
+}
+
 static void print_sym(struct sym *s)
 {
 	info("sym:    %s\n", s->name);
@@ -380,18 +603,23 @@ static void print_sym(struct sym *s)
 
 static void print_usage(char *e)
 {
-	printf("Usage %s [-s <System.map>] -b <vmlinux> -c <certfile>\n", e);
+	printf("Usage: %s [-s <System.map>] -b <vmlinux> -c <certfile>\n", e);
+	printf("       %s [-s <System.map>] -z <bzImage> -c <certfile>\n", e);
 }
 
 int main(int argc, char **argv)
 {
 	char *system_map_file = NULL;
 	char *vmlinux_file = NULL;
+	char *bzimage_file = NULL;
 	char *cert_file = NULL;
 	int vmlinux_size;
+	int bzimage_size;
 	int cert_size;
 	char *vmlinux;
 	char *cert;
+	char *bzimage = NULL;
+	struct zipper *z = NULL;
 	FILE *system_map;
 	int *used;
 	int opt;
@@ -399,7 +627,7 @@ int main(int argc, char **argv)
 	struct elf elf;
 	unsigned char *symtab = NULL;
 
-	while ((opt = getopt(argc, argv, "b:c:s:")) != -1) {
+	while ((opt = getopt(argc, argv, "b:z:c:s:")) != -1) {
 		switch (opt) {
 		case 's':
 			system_map_file = optarg;
@@ -407,6 +635,9 @@ int main(int argc, char **argv)
 		case 'b':
 			vmlinux_file = optarg;
 			break;
+		case 'z':
+			bzimage_file = optarg;
+			break;
 		case 'c':
 			cert_file = optarg;
 			break;
@@ -415,7 +646,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!vmlinux_file || !cert_file) {
+	if (!cert_file ||
+	    (!vmlinux_file && !bzimage_file) ||
+	    (vmlinux_file && bzimage_file)) {
 		print_usage(argv[0]);
 		exit(EXIT_FAILURE);
 	}
@@ -424,6 +657,16 @@ int main(int argc, char **argv)
 	if (!cert)
 		exit(EXIT_FAILURE);
 
+	if (bzimage_file) {
+		bzimage = map_file(bzimage_file, &bzimage_size);
+		if (!bzimage)
+			exit(EXIT_FAILURE);
+
+		extract_vmlinux(bzimage, bzimage_size, &vmlinux_file, &z);
+		if (!vmlinux_file)
+			exit(EXIT_FAILURE);
+	}
+
 	vmlinux = map_file(vmlinux_file, &vmlinux_size);
 	if (!vmlinux)
 		exit(EXIT_FAILURE);
@@ -477,7 +720,7 @@ int main(int argc, char **argv)
 	}
 
 	/* If the existing cert is the same, don't overwrite */
-	if (cert_size == *used &&
+	if (cert_size > 0 && cert_size == *used &&
 	    strncmp(cert_sym.content, cert, cert_size) == 0) {
 		warn("Certificate was already inserted.\n");
 		exit(EXIT_SUCCESS);
@@ -511,5 +754,9 @@ int main(int argc, char **argv)
 		perror(vmlinux_file);
 		exit(EXIT_FAILURE);
 	}
+
+	if (bzimage)
+		repack_image(bzimage, bzimage_size, vmlinux_file, z);
+
 	exit(EXIT_SUCCESS);
 }
-- 
2.17.0
