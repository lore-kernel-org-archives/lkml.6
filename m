Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx498M/SJQjk5FkmBLDBVWn+s0IGiW5MMc2dzAZzA3qHKWiP7YPqfhiw3aGhAXFd5R93qyOhm
ARC-Seal: i=1; a=rsa-sha256; t=1524653061; cv=none;
        d=google.com; s=arc-20160816;
        b=KRAto89XU9WgjMKGJU5+CIwHcf2H8RkIZZXaLsc3v9ubnCUWIMsTLSE7bXYRSW0Qa5
         8e/3R/6R2rGp/xidjf64pWdWEW6ImlZokYUNRSbI+MKUGrIeHHsVlj2E2prMiT/zZeh4
         XMGJ+YUPeI5nX/5i47p5XcWVZ9yNN8gLg45zk47aqLYSPHkNBufyVV04UjbeNgwylJlN
         VmYr8KW5RbCFvuBtJu9Zz/EkhXgtiJwOsT0AjWAZvdYVjUvvUsq1fJHKh7anycU3xxxj
         DEwIWIZAKrYRZm0kFw/2/uGQFRJwI2RKU/LfmyFIMdA4DABuLfTA+aYudFOhd14Z5Zcq
         JO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b5yKsCtSErAdNjN82tSeOkdI5A8i6VVeOB7Yi0u7I2Y=;
        b=XopZUCiE8c/bTrjAtO9zXXA0m8zPTTr2svxItzZx1gPXwxm7kkupwYMe0Gt+4Xu0v1
         umFJ8fLfPYHn1NYmSQ2BHfEH4ByLUpDnQKIeKY6pSh5PYVjwzInE82AjYfMDvbZE5fx3
         A2SdTiA5Nx9S9Y1gO+Irzx5JdwmIOjL3469QQ6On9KfV5kztSHfgRzf7qMIp76rm58wh
         dw0F7n3mZtgMwqj1P4U+1XPHGQCIuPTEj5+5Wsa9lBslactXJo/nrj5QyRWLyPzi6uXm
         59w/jJpLPBhYXs1+LT/OmhMJa3VIO2yPmsBafBLkL8lO9JY598/QfuOsmYcfBv6pOynY
         90Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 169/183] irqchip/gic-v3: Ignore disabled ITS nodes
Date: Wed, 25 Apr 2018 12:36:29 +0200
Message-Id: <20180425103249.310787551@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714609073001485?=
X-GMAIL-MSGID: =?utf-8?q?1598714609073001485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>


[ Upstream commit 95a2562590c2f64a0398183f978d5cf3db6d0284 ]

On some platforms there's an ITS available but it's not enabled
because reading or writing the registers is denied by the
firmware. In fact, reading or writing them will cause the system
to reset. We could remove the node from DT in such a case, but
it's better to skip nodes that are marked as "disabled" in DT so
that we can describe the hardware that exists and use the status
property to indicate how the firmware has configured things.

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c               |    2 ++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c          |    2 ++
 drivers/irqchip/irq-gic-v3-its.c                       |    2 ++
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |    2 ++
 4 files changed, 8 insertions(+)

--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -132,6 +132,8 @@ static int __init its_pci_of_msi_init(vo
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -154,6 +154,8 @@ static void __init its_pmsi_of_init(void
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3083,6 +3083,8 @@ static int __init its_of_probe(struct de
 
 	for (np = of_find_matching_node(node, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
 			pr_warn("%pOF: no msi-controller property, ITS ignored\n",
 				np);
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -75,6 +75,8 @@ int __init its_fsl_mc_msi_init(void)
 
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
+		if (!of_device_is_available(np))
+			continue;
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
