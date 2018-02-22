Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeBVP6m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:58:42 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932952AbeBVP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:58:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Suman Anna <s-anna@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH] soc: qcom: qmi: add CONFIG_NET dependency
Date: Thu, 22 Feb 2018 16:57:38 +0100
Message-Id: <20180222155833.1860318-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:oPYdjMrbokSh/dqWP98N6I9tpCGYwC8gh3npXygKphciOzk7Ul/
 HjFxB21AnKMJJroxFhxTg37OV1daCW/WwKdcNiNVub85xrIcX+bz4inUJZbTrs6x2eoup60
 5ciQ+TJu+2Qr5DT+5bAzXxaOgf6M7d7iqOKjpTVxA8WcRjrcCZefqUF5C6rvkQChfVKOq89
 4vahR8UiSuxmGzy53kECQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UNuTRrnqTBE=:3DrXU8BaHa28RcYkXZpe4J
 yELsU/gvPbwVpoE5f4hCUDwHKhJr1LD91RzbnGFPIu6uFgEzBJPoiWPoCu7Kx/h3Gt7Uwwigw
 sl4D0D/n612dTST1lyV1xqIfQskMdOBjBgMcEjM6996RQz9RXmTEbpN29h+Ts/nhRakhx8GSf
 9I75CwoaHNuHVNbzkAjBFWSNsCcTGg8iCP7s12+inc9DZpkaEiyWYQUI4Vlhuv8NS2qUqJl+O
 W0MXM+tjgZ2SC+RlQ9v6mDvRLwOQGz2v6aUImotbvb52wvAFBMxr5c4qZn+QImfbAzC1ROr4j
 yEVLWJnUEOfs9CJCGUE7W2oQMfcJRuZjaxKUYXTCsi7XFsC9rv9OnqkdGIe0/qTyKa1651Zbv
 O4zrvrCTCAE9X+sQlhXIUTi6MedROGYqYwzNCb5SP9Vyy1hmVl282eMaNvwyNvnGtfw+Eduw5
 TDaT/sJjibk1xlGPRj3/tXcibPwduRaqFag1xQFpGhhTHRx5RKCzzR+V28590J1vPru6t0aBL
 uy5+rIN1i4VaAzoJKJ9sBQj0Jq0E3/3E+UxLrQVj07HyNB28CIZ4BNvXEXI8CD8AqssT8us6z
 vs6Ckc/2EqnK315iBYLjUZ/5l+9XeIlVrGrEwZfwTYauS7asdDE3c7N0XaqJd/mtZmzi6yN8u
 cb/jzl5Dm6ipocr0qrIeSk4jijXWSCCufTSNbsrl48CKRcNMl44mN15Nmn8399XoXo38OTTxo
 RYQsEeCJMMKtuSFKPR1cWU1t1sTanBctqrb0cA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the socket API and the root network namespace is only available
when networking is enabled:

ERROR: "kernel_sendmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!
ERROR: "sock_release" [drivers/soc/qcom/qmi_helpers.ko] undefined!
ERROR: "sock_create_kern" [drivers/soc/qcom/qmi_helpers.ko] undefined!
ERROR: "kernel_getsockname" [drivers/soc/qcom/qmi_helpers.ko] undefined!
ERROR: "init_net" [drivers/soc/qcom/qmi_helpers.ko] undefined!
ERROR: "kernel_recvmsg" [drivers/soc/qcom/qmi_helpers.ko] undefined!

Adding a dependency on CONFIG_NET lets us build it in all randconfig
builds.

Fixes: 9b8a11e82615 ("soc: qcom: Introduce QMI encoder/decoder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/Kconfig | 1 +
 drivers/soc/qcom/Kconfig   | 2 +-
 samples/Kconfig            | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a3658aa01838..027274008b08 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -121,6 +121,7 @@ config QCOM_SYSMON
 	tristate "Qualcomm sysmon driver"
 	depends on RPMSG
 	depends on ARCH_QCOM
+	depends on NET
 	select QCOM_QMI_HELPERS
 	help
 	  The sysmon driver implements a sysmon QMI client and a handler for
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb83341d..506763d81766 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -37,7 +37,7 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM && NET
 	help
 	  Helper library for handling QMI encoded messages.  QMI encoded
 	  messages are used in communication between the majority of QRTR
diff --git a/samples/Kconfig b/samples/Kconfig
index 4cb8af2f810f..168291de0184 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -66,6 +66,7 @@ config SAMPLE_QMI_CLIENT
 	tristate "Build qmi client sample -- loadable modules only"
 	depends on m
 	depends on ARCH_QCOM
+	depends on NET
 	select QCOM_QMI_HELPERS
 	help
 	  Build an QMI client sample driver, which demonstrates how to
-- 
2.9.0
