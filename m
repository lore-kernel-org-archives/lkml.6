Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeCKIRT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 04:17:19 -0400
Received: from mout.web.de ([217.72.192.78]:45959 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932093AbeCKIRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 04:17:16 -0400
To: linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
        Josh Sklar <sklar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] powerpc: Use common error handling code in setup_new_fdt()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
Date: Sun, 11 Mar 2018 09:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:8BWavJHWazl5IkpgzQ6ewok6qzGaEIAwf6UzDQjs+lkOJKQrN/v
 j/DezU+n1Ka9xaXtGyp2EJntQ+kdtEFIFgSlDCi7yB1v1loze0nfC0BFdXL+JXKWtH5sdfC
 RVMkCobMUMOWtgW+X4HaFjoB55+9b0w9ok+eY75VktiRU4T3zuiKq9IZg+7R3k4nlMAaNGJ
 T7B2UlOIIX7QSyi6KDHHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgNqwrkyNSo=:pHwko/8qCX4MfL1v8fsMvm
 wR4gr07CqF0nE8tb1qIS3LaIvooTKxHbF2Cs4cvKJzmyEL9exfgr/+zCL8EEiztyUM8cysztL
 BbVthmB8ury7gfooKaLqAtdPomvqi47UMzQyR7JfuH9Dyxpb9g9Z4NpbdohgWeNgpnpEBLeKL
 3Qm9mBxGbfvRjCg+Gi3TY9tWe3KumEwdjeQkleSnGZc+dxbGyF3ek1CGJUC8FmmohrP6XPEYB
 xbTGFtNLVVqQzpjUM5qE0r5YLFRvDv3ALw98XRHnQj259D2qIVGpB9RT02/c8jBgMBqLbhAcS
 NO8xRAqdnSib9UOQw//ZfxeaxPyX/Hit46hfi104J/kIWydeTjDdvhnI+gr967gNs1VmAuFAA
 jNkqftyh5EXrcQy3TjdIWxIcPtTtrnSG2MOMbBYY/a1ZN6ZW7zVl9IxfiB1rv0NqtJMjqUeyl
 BS9rokgteC8N9r+LVxm0o384eQRdzKwitaMOPFI97AzmsLVHdQ4zN3Y6H1+Eqiqg3UIuMImRW
 zmma3FxngkJyumpoI3Epo2/1H733/oQmlm8SGlBpPiOug6/kaCx3zMea8kK4DCqlB+IJREgfx
 OjvLr1Sj0OclE8BzUHp5VFFyRW4iepKLP8r/+/29x0WEiliwz5S+rCAT+BjgQgjZ2iDZ8TJYH
 +UlB7I+6Cv7XPHt6fohUaywMswSvlcQwGdlYu7VMB98eCUXxubtl9pwc38nco4vV9biiq1+la
 ORf3kPY9jyFBDPQKMqtmQr51kw6VlawNmBzJxa42E8QFf9xkZ0jpR94UFzV7/fm7Vt6kufcDG
 aMmNq9xX/4L69QeILJEgy3nDrYD+sCDPzydQ1mwT6s/ErJd10g=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 09:03:42 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index e4395f937d63..90c6004c2eec 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -302,18 +302,14 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 		ret = fdt_setprop_u64(fdt, chosen_node,
 				      "linux,initrd-start",
 				      initrd_load_addr);
-		if (ret < 0) {
-			pr_err("Error setting up the new device tree.\n");
-			return -EINVAL;
-		}
+		if (ret < 0)
+			goto report_setup_failure;
 
 		/* initrd-end is the first address after the initrd image. */
 		ret = fdt_setprop_u64(fdt, chosen_node, "linux,initrd-end",
 				      initrd_load_addr + initrd_len);
-		if (ret < 0) {
-			pr_err("Error setting up the new device tree.\n");
-			return -EINVAL;
-		}
+		if (ret < 0)
+			goto report_setup_failure;
 
 		ret = fdt_add_mem_rsv(fdt, initrd_load_addr, initrd_len);
 		if (ret) {
@@ -325,10 +321,8 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 
 	if (cmdline != NULL) {
 		ret = fdt_setprop_string(fdt, chosen_node, "bootargs", cmdline);
-		if (ret < 0) {
-			pr_err("Error setting up the new device tree.\n");
-			return -EINVAL;
-		}
+		if (ret < 0)
+			goto report_setup_failure;
 	} else {
 		ret = fdt_delprop(fdt, chosen_node, "bootargs");
 		if (ret && ret != -FDT_ERR_NOTFOUND) {
@@ -344,10 +338,12 @@ int setup_new_fdt(const struct kimage *image, void *fdt,
 	}
 
 	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
-	if (ret) {
-		pr_err("Error setting up the new device tree.\n");
-		return -EINVAL;
-	}
+	if (ret)
+		goto report_setup_failure;
 
 	return 0;
+
+report_setup_failure:
+	pr_err("Error setting up the new device tree.\n");
+	return -EINVAL;
 }
-- 
2.16.2
