Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELs4M6t9H6P6HqBEm5Sm4xBzZfqLvpDj+XROvASMic/zIU4LElx8I2Kl1AQmkMfEXU+Ddvnr
ARC-Seal: i=1; a=rsa-sha256; t=1519947169; cv=none;
        d=google.com; s=arc-20160816;
        b=Lv5GNsilO11QmdGSW8fFSlzEwxRRrLGunUA6POBXKovwYykhBVMGS+VYU6XYtNJng+
         brfrCfsTTt8+vonH1JA6v9emRQI780pYtdW2KJK2KniTTkCosXXVHto5YjZ/WrIJ8eUk
         jmQgZS7/0ao+5sdlR/NroorlW3AJTKhSRBnU7y0himkaak6zZC/qprobhYr+hwmyUBa4
         DUJUbXh/XWSzwe8uK4Y2yF0RtX0ZfhArTZ+zKLrvB4dT0zLoEFNjytNgdo0DBvF4VjDr
         5kY9c8j2C7jNsDGdxmWeEz0p9u34dEVkbC9xPaqPDh0N9PRGzcY0UMZQC1ARA1ia13FK
         sRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=tBELZujbB3VRp2zcxvnAAFkPRKWsF8BmRkALZ40QN3E=;
        b=AY/NeXTDRutN4U3EqAUNaJBzx9AWbkIoEJDOs6fz5zwsjqsBRlhkLAGZjiKZ6UBEss
         ebmO5RS/Bh1Bdpt+OOX1o9KPNN3qIp5IyW90S1PDxHtje9wqwxss5c140ypEiFr8BJ/B
         H3MkTC7LOAhEx9ZAj3Y7xs3YZ0ZY/9Eoiuc1xaAv4MjnOo5N9cIalP6ERjJibtL+sOcV
         ocNQRaCuZXZL0jL1oN7XYRehZMAA3FNVF8SB1bbuoWNxwucNA9sQbZy1mFZBnvFRFpZ6
         +F6u4OmucNr2/kdsQXspLxvS62wEjtQQgz/q+VbVRanRkenRgcjz1L2/pWvzaOUlLQGN
         ubRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 05/17] staging: lustre: lnet: keep ln_nportals consistent
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708521.7628.13905456558048566520.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780122780902634?=
X-GMAIL-MSGID: =?utf-8?q?1593780122780902634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ln_nportals should be zero when no portals have
been allocated.  This ensures that memory allocation failure
is handled correctly elsewhere.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lnet/lnet/lib-ptl.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/lnet/lib-ptl.c b/drivers/staging/lustre/lnet/lnet/lib-ptl.c
index 471f2f6c86f4..fc47379c5938 100644
--- a/drivers/staging/lustre/lnet/lnet/lib-ptl.c
+++ b/drivers/staging/lustre/lnet/lnet/lib-ptl.c
@@ -841,6 +841,7 @@ lnet_portals_destroy(void)
 
 	cfs_array_free(the_lnet.ln_portals);
 	the_lnet.ln_portals = NULL;
+	the_lnet.ln_nportals = 0;
 }
 
 int
@@ -851,12 +852,12 @@ lnet_portals_create(void)
 
 	size = offsetof(struct lnet_portal, ptl_mt_maps[LNET_CPT_NUMBER]);
 
-	the_lnet.ln_nportals = MAX_PORTALS;
-	the_lnet.ln_portals = cfs_array_alloc(the_lnet.ln_nportals, size);
+	the_lnet.ln_portals = cfs_array_alloc(MAX_PORTALS, size);
 	if (!the_lnet.ln_portals) {
 		CERROR("Failed to allocate portals table\n");
 		return -ENOMEM;
 	}
+	the_lnet.ln_nportals = MAX_PORTALS;
 
 	for (i = 0; i < the_lnet.ln_nportals; i++) {
 		if (lnet_ptl_setup(the_lnet.ln_portals[i], i)) {
