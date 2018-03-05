Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELtDVR+GNkLeOpxhBeN+RB/p2k9wfmrihLX0lk90plTRATzseNImherfHNBKwmKF5miXsBE/
ARC-Seal: i=1; a=rsa-sha256; t=1520266916; cv=none;
        d=google.com; s=arc-20160816;
        b=0bvpghIsiDaxUOX7Uoh84YAs0AwvUfa4ainkcuAvtY1uRFkPgBVsvUSeOYoeMEn+kj
         UGpKzvmThKJrGf1gwVTlvXHWZ+z0FGpbq17n2WA8QABvYmT1cWt8fOug5T4eMwXj33Nq
         /YCnYe8bRYSn0JDTSsw6VVc0rOBAFXydkc5uQpqQSNVSoEw/AfKF3XEW+K0c5C3jBtSb
         2isQLQyIdhRCFdQ/vdmwNJYXdcu+thwvgxHBj84wXCtH1DgoHYgodn1hV0CCtSkB/Vgv
         ZGUcPDRlcXzCRiwSiHaG9yRfN8yRY5S2AWC0ot4xCCKUl7ZN2SOMChrovlOEWv98TTWg
         jD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :arc-authentication-results;
        bh=RWw9ybRH54vBdbRpMGUNx/8z2AU5A0rByMtAbRS/SB4=;
        b=03Gl4j+ENK/A3WncBKBgjeXZOizdkkaCp82i/tQXBHYuDw/TutcGcnsmjZ+yP00DW9
         OoU5Ksr6HzKQwMYxL0jSovjasNVXoWagRp38EE9qY8hWSFspjC7CxhuLKppyS+CAzTDG
         nrBuM5ssMA1Tsotd0xjmiqSt4EfNoGxYRwd3x+AUvMYUSaUlow7SX4czpyMHApO8RkS9
         xiOp58calxyZ+d/MtM2cRocEGbyZcLif/gfwcJPB6dSkZdn3Gh0vHpRg6wp7n+mr1S+i
         G4BxdEX6KoiBzw1Q06rQEiTKOiYA6frt5Wn6ut/4B265dC8cl/+VXsH+khvWbO070yCZ
         sC4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 217.72.192.78 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: [PATCH 2/2] VMCI: Improve a size determination in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 George Zhang <georgezhang@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy King <acking@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
References: <66411a1a-fd12-dc31-fc2e-800ff6cea1ed@users.sourceforge.net>
Message-ID: <06589ca3-cab3-a71e-fbd2-cecf473ab9ec@users.sourceforge.net>
Date: Mon, 5 Mar 2018 17:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <66411a1a-fd12-dc31-fc2e-800ff6cea1ed@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jYTFzaccAkLDwv7GhOo0uTR/j9kfsdJ4Tgql6ia/LM+95eHBpWQ
 mwuNbhmN2qC/SCbESgmjXE8gDDVIOSGLLF9kR1YqUjBRnXn+1QUZzrT0+B0lYZU+pXZNLOo
 qH714HqGO2RlJEje7z1yLW6gsZpjc9kCB7I0YgiZEP9tzG0zEffv1YyjsUX6iJmPw9WYtwO
 brLyXVkANqRvH0cg9ImNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z6owvua2J8k=:P+cLoMoLa+VjAze4nYtikq
 PgUNxwU7hzRrlq5Tq1Io0z6S+e8JS8Jy8MHuIFZRKAASP2YRX2f55HVkD7Jb8qahfqa165Uff
 hHuBk5ArM1l3lzFAW9W9Oc0elH0qg32j3AC0Oz2Tm9ywMBZJJ3K8DWmxTN+H9TZogen6zZTd4
 VXJDMsYu4XkZe5DVKUslMs9ru+6H3bTx3SneqtBzKoT81T21ab3EE5wkCioYkZHPYeEmrYJn1
 F8H+OpERvIm+4TlLxPDjoG0N1CiasdD/gaHONSmU2g5gGSQ21OEn6Z9wUMsoiOYoFUalbpL1b
 dXUhA0eaKV8SEeOf0Af270/XEn/+w97s2UQBMboJzdW29G7Wf5muE9MMSU9yxsc6inhLk7BJD
 ac0ZphV+A7FtKEfzPW3xsXZYKDvhSYhvWd4R9CN1TfzQeFh5lPzZje8KMB0bKIBiWxzGr59u3
 +WGC1Atyh+q43XlJ0BxbR3iydDucTQfoCoeYDPd623aV3ayp7p7SX1NjA36P3irkXCirUK9pi
 aVWU57I0KrK97CHJ/uec7g/XzR5L/KCAGYSqjSNYetF39M3tY6ySXreXQRUnNInEtg40C5zEe
 F9dc1Nil78EYfsZLwfEJYCzSkzSgk/mKduTBHI+UFHs52kDLfpBN4U8WWdmS6+e2664MQ6U3I
 7ckD3MBVVvjet6kdDRZuaQK0FnOxzOUd8Gqy3G1JmBTmKdC3rZFhjSt6Yvm//7DVYcwgeJSFZ
 3jiibAgYskRdCeEIZN2gqPinwUndLWWFlyieaXStOLjOUvxFqzXOY2phFyfnrYhvpYF0vxauR
 1n3tdih8N/waDPlTibDGDGmceHXv1rNIjJtUxzWSFOSh0lbDwE=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594115401760613701?=
X-GMAIL-MSGID: =?utf-8?q?1594115401760613701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 17:00:19 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 +-
 drivers/misc/vmw_vmci/vmci_host.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 21d0fa592145..18404318dd71 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -620,7 +620,7 @@ int vmci_ctx_add_notification(u32 context_id, u32 remote_cid)
 		goto out;
 	}
 
-	notifier = kmalloc(sizeof(struct vmci_handle_list), GFP_KERNEL);
+	notifier = kmalloc(sizeof(*notifier), GFP_KERNEL);
 	if (!notifier) {
 		result = VMCI_ERROR_NO_MEM;
 		goto out;
diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index fb3d92a21afa..12419f97681d 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -124,7 +124,7 @@ static int vmci_host_open(struct inode *inode, struct file *filp)
 {
 	struct vmci_host_dev *vmci_host_dev;
 
-	vmci_host_dev = kzalloc(sizeof(struct vmci_host_dev), GFP_KERNEL);
+	vmci_host_dev = kzalloc(sizeof(*vmci_host_dev), GFP_KERNEL);
 	if (vmci_host_dev == NULL)
 		return -ENOMEM;
 
-- 
2.16.2
