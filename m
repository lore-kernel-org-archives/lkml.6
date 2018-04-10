Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+aV+3INT8jg3iNEbYSqOaIDqRSy1Cq5joQtuxXMaQKmV7WxkU+7ReUqAXTc0JEIIlx/ISn
ARC-Seal: i=1; a=rsa-sha256; t=1523399432; cv=none;
        d=google.com; s=arc-20160816;
        b=f06KrzGKbSnDxhcKNNc/fua7EMxniSvsxCWG1z2JFPOVsNjDhelDq5zDpv3lkKJ97K
         wNk7zhNFlQW6WLSciFUHoOktLintpoaP3KOjCMQvuzUI9RQfpgGXz8tj1lZQl60N0Fff
         /3iOLb3Sae3y8+sk1AoDKuhiSZgSo7Y4k5+l+DxI0i0YUzrbKMC+6s68ujfqYW4EDqr/
         X1nkkWCqc8bhpYRVdDYSGWkxBI9eb/5PqN9gxciSmDckBgX7rYAOCiZ3c6Qftaa3BeLC
         OxdHaYqpkDmnVFcYGSq6p1+FMN4PdilFk462NhAPkMb/CE9o3KQ7cUUvRKJP5MU8hpmG
         BTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iAS4UHqg9i1jEDw3U1g7IFlexnpMJvfRnVeHtPZBYQ4=;
        b=XwQWcXl1vA+6SSjZNNf/ZBtpkCdGZcF1z083cc1Im3XqJj857nxCEoGiyH4ykF+0Sj
         JIjsmoSfZhiOXd8wVpi92JCbabwMUsDXxW1WE13dM4gPQM6TricO4JoVXmP6kUd2m+rd
         BpQAligyQemSOCiUssALOQLRJXAV96W0/GBpH0ciV7iiV0XwCBbvElRqojLYtX/ZZpg3
         QpSsz3H2DiNgBtN7vXexQhNbtpry9UDsE5s56uS2aI6jt3s2jflbSPydtJO+WrDrCL2S
         ezhonuRujkjJEWt9gElnRoBOF2A0DxecbxSdDSaq9M7nBiIGJHpAMbszN9eFgrO6xoy1
         GDVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Christie <mchristi@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 105/168] tcmu: release blocks for partially setup cmds
Date: Wed, 11 Apr 2018 00:24:07 +0200
Message-Id: <20180410212804.710990639@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400083377091029?=
X-GMAIL-MSGID: =?utf-8?q?1597400083377091029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <mchristi@redhat.com>


[ Upstream commit 810b8153c4243d2012a6ec002ddd3bbc9a9ae8c2 ]

If we cannot setup a cmd because we run out of ring space
or global pages release the blocks before sleeping. This
prevents a deadlock where dev0 has waiting_blocks set and
needs N blocks, but dev1 to devX have each allocated N / X blocks
and also hit the global block limit so they went to sleep.

find_free_blocks is not able to take the sleeping dev's
blocks becaause their waiting_blocks is set and even
if it was not the block returned by find_last_bit could equal
dbi_max. The latter will probably never happen because
DATA_BLOCK_BITS is so high but in the next patches
DATA_BLOCK_BITS and TCMU_GLOBAL_MAX_BLOCKS will be settable so
it might be lower and could happen.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_user.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -805,6 +805,13 @@ tcmu_queue_cmd_ring(struct tcmu_cmd *tcm
 		int ret;
 		DEFINE_WAIT(__wait);
 
+		/*
+		 * Don't leave commands partially setup because the unmap
+		 * thread might need the blocks to make forward progress.
+		 */
+		tcmu_cmd_free_data(tcmu_cmd, tcmu_cmd->dbi_cur);
+		tcmu_cmd_reset_dbi_cur(tcmu_cmd);
+
 		prepare_to_wait(&udev->wait_cmdr, &__wait, TASK_INTERRUPTIBLE);
 
 		pr_debug("sleeping for ring space\n");
