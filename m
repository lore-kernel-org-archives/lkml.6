Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELvDBZS/atc/8PkWqFtZw1xy2Rq4GyRzBzkNPXaP5xOtHMwOB8bCL/y3IHv/AEkQsVQtYnyw
ARC-Seal: i=1; a=rsa-sha256; t=1519403064; cv=none;
        d=google.com; s=arc-20160816;
        b=Eqy2fniSCetbNlw0C5ED/P+gNjsAw3wMFRRkRbLIyg3gHQoDihxqYHnBfv4iE/6iIP
         tVEPUTtB7t/ObAHTJzIunVZYVyXUln27iUNheQGIfDr+1ndUCgV+bfbTOmOy5o9GPAux
         DFhTxziK/5GfoycdriIzMGuzul5ti8dfRutXewsnFEBXNbF/Lr/0nG2CU2qLurqtNXbo
         hCPc747ogLXkQL72Yhy9oixdqg41WWOE3LcdV+J0yGDhKjLVpJxIOU/wiSBXeSjW16nG
         RxWQWwgemDsc9BExH/DoTBBklQJMvzEUBZO3LUoS2iXhcY6Jxv6bdn6bl0cVZs0ufDm8
         j6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Y0e438AbNZGV4jRNOTibkRRfu0RQOywdAEDSZWaPuas=;
        b=ER0gsgYhYGjIJCsflrZsfs64XvqIhAU0Yel61bWQfQyGDxw7/kuGyakTBtkp9bPc9U
         0bLxmOE4SHRwXnbTt2KRRJ4A3NXHnKukTZ1J5p+XRnaEO6XeHubeP23qVl1fBO970NmW
         BxnWShRCk+dQ0GVxTwocy882JQp8rs4hsBnwHV4n+NbK+tG751uVWqStHjhtQiFeDKkZ
         Kj96dFkt8fHp28EKYteNxDys2IKISiX2DDLrtjqznyobuj4HGaiQneoFntczXbgdralz
         cj8fCQoxtHS+mEfzgC1IvanOmF+iLPL7YPOIPGoBH+HsnnxsW6ijez+33x22SCTWLUYk
         4njQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 10/20] firmware: arm_scmi: probe and initialise all the supported protocols
Date: Fri, 23 Feb 2018 16:23:40 +0000
Message-Id: <1519403030-21189-11-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209588036831874?=
X-GMAIL-MSGID: =?utf-8?q?1593209588036831874?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that we have basic support for all the protocols in the
specification, let's probe them individually and initialise them.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 51 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index ba784b8ec170..970c3a8c6e96 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -477,6 +477,21 @@ void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
 	info->protocols_imp = prot_imp;
 }
 
+static bool
+scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
+{
+	int i;
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	if (!info->protocols_imp)
+		return false;
+
+	for (i = 0; i < MAX_PROTOCOLS_IMP; i++)
+		if (info->protocols_imp[i] == prot_id)
+			return true;
+	return false;
+}
+
 /**
  * scmi_handle_get() - Get the  SCMI handle for a device
  *
@@ -672,6 +687,23 @@ static inline int scmi_mbox_chan_setup(struct scmi_info *info)
 	return 0;
 }
 
+static inline void
+scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
+			    int prot_id)
+{
+	struct scmi_device *sdev;
+
+	sdev = scmi_device_create(np, info->dev, prot_id);
+	if (!sdev) {
+		dev_err(info->dev, "failed to create %d protocol device\n",
+			prot_id);
+		return;
+	}
+
+	/* setup handle now as the transport is ready */
+	scmi_set_handle(sdev);
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -679,7 +711,7 @@ static int scmi_probe(struct platform_device *pdev)
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
+	struct device_node *child, *np = dev->of_node;
 
 	/* Only mailbox method supported, check for the presence of one */
 	if (scmi_mailbox_check(np)) {
@@ -722,6 +754,23 @@ static int scmi_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &scmi_list);
 	mutex_unlock(&scmi_list_mutex);
 
+	for_each_available_child_of_node(np, child) {
+		u32 prot_id;
+
+		if (of_property_read_u32(child, "reg", &prot_id))
+			continue;
+
+		prot_id &= MSG_PROTOCOL_ID_MASK;
+
+		if (!scmi_is_protocol_implemented(handle, prot_id)) {
+			dev_err(dev, "SCMI protocol %d not implemented\n",
+				prot_id);
+			continue;
+		}
+
+		scmi_create_protocol_device(child, info, prot_id);
+	}
+
 	return 0;
 }
 
-- 
2.7.4
