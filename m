Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFpfKLfKwzGNC5kz4+UlAOticxXuhqcId2dIJ/g1IGLNPv06Go8im03IMgLSNfEtwnIE2v
ARC-Seal: i=1; a=rsa-sha256; t=1521800149; cv=none;
        d=google.com; s=arc-20160816;
        b=hr5BoqjdMeX/1pCs9vmRFJIlsG7oLi/PASCL9zgeD4fGn7ggGWCnnvOmxSOGzI+lj+
         +hJ5B/Fh8CRfHsK0Cki0MPTAhoEZpLzFd8Ej0trSrfKW0ARPsNGVWv667KJKgtHPQGSY
         jl8I/g3nc/52YbP/nzZfTSrQpaG1LlBBERGKBIix3oHzMiEea5gRYk6utZM7EER33xz8
         rYnszf8Xc4p2x6OPVj7Hne0USsORiifuqcJQ/oB5Xkt63j78WJ4nI1bNIJnvqslZQvVd
         n6MPnBpmNiNCqjVrLctD/ABpH4v0VVUlZ19gNqY82edg3QP2rGQTW1wOEhCVjLjJTCiS
         FWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2WycRnY3YeGClgCpDhAWOT0rzD/T4tA4KCvY3yzl7ag=;
        b=N9Ce+u5HSK0RF5Oa8uuKzcGxWkmY7frACKTmN3u/A3wreuDY+ahzMqD2B3U3zTdXew
         kTTzXfUnkkgYYGfajMbkWJ81KQhKlV3Ptn8tDibbnj9CyCLClHwYJaEmemKZZrwcPJHn
         YwGke2Wu6vgVIPCpYqJaQ0SmQnLRengKUFKHHLvash5exAuqzFX0F/PSFzL4A69Ve8fh
         AwTSHt8329TBquCIIvaNRPKJlCIqinTU5or5Yt4Cd9jzBlzOY1S5SLS5sO7k5u5eVRM2
         vGAjBiO9GCXIq07sljd7iRKeYlUiunwqoKo1J4c2EDFh993IEbYdWMIf8PHPHQWQHUEC
         MdAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>,
	David Kershner <david.kershner@unisys.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 53/97] staging: unisys: visorhba: fix s-Par to boot with option CONFIG_VMAP_STACK set to y
Date: Fri, 23 Mar 2018 10:54:40 +0100
Message-Id: <20180323094200.634018655@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722700204077922?=
X-GMAIL-MSGID: =?utf-8?q?1595723113905633652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>


[ Upstream commit 3c2bf0bd08123f3497bd3e84bd9088c937b0cb40 ]

The root issue is that we are not allowed to have items on the
stack being passed to "DMA" like operations. In this case we have
a vmcall and an inline completion of scsi command.

This patch fixes the issue by moving the variables on stack in
do_scsi_nolinuxstat() to heap memory.

Signed-off-by: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>
Signed-off-by: David Kershner <david.kershner@unisys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/unisys/visorhba/visorhba_main.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -792,7 +792,7 @@ static void
 do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct scsi_cmnd *scsicmd)
 {
 	struct scsi_device *scsidev;
-	unsigned char buf[36];
+	unsigned char *buf;
 	struct scatterlist *sg;
 	unsigned int i;
 	char *this_page;
@@ -807,6 +807,10 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 		if (cmdrsp->scsi.no_disk_result == 0)
 			return;
 
+		buf = kzalloc(sizeof(char) * 36, GFP_KERNEL);
+		if (!buf)
+			return;
+
 		/* Linux scsi code wants a device at Lun 0
 		 * to issue report luns, but we don't want
 		 * a disk there so we'll present a processor
@@ -820,6 +824,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 		if (scsi_sg_count(scsicmd) == 0) {
 			memcpy(scsi_sglist(scsicmd), buf,
 			       cmdrsp->scsi.bufflen);
+			kfree(buf);
 			return;
 		}
 
@@ -831,6 +836,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 			memcpy(this_page, buf + bufind, sg[i].length);
 			kunmap_atomic(this_page_orig);
 		}
+		kfree(buf);
 	} else {
 		devdata = (struct visorhba_devdata *)scsidev->host->hostdata;
 		for_each_vdisk_match(vdisk, devdata, scsidev) {
