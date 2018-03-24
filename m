Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeCXC7v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 22:59:51 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35377 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751288AbeCXC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 22:59:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T--L1Xh_1521860387;
From: Jia Zhang <zhang.jia@linux.alibaba.com>
To: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com
Subject: [PATCH v3 0/3][RESEND] modsign enhancement
Date: Sat, 24 Mar 2018 10:59:46 +0800
Message-Id: <1521860389-19262-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series allows to disable module validity enforcement
in runtime through the control switch located in securityfs.

In order to keep /sys/module/module/parameters/sig_enforce simple,
the disablement switch is located at
/sys/kernel/security/modsign/disable_enforce.

Assuming CONFIG_MODULE_SIG_FORCE=n, here are the instructions to
test this control switch.

# cat /sys/module/module/parameters/sig_enforce
N
# echo 1 > /sys/module/module/parameters/sig_enforce
# cat /sys/module/module/parameters/sig_enforce
Y
# echo -n 0 > no_sig_enforce
# openssl smime -sign -nocerts -noattr -binary -in no_sig_enforce \
    -inkey <system_trusted_key> -signer <cert> -outform der \
    -out /sys/kernel/security/modsign/disable_enforce
# cat /sys/module/module/parameters/sig_enforce
N

Changelog:
v3:
- The control switch now doesn't support showing the status of sig_enforce.

v2:
- Support to disable validity enforcement in runtime.
