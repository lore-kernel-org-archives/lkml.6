Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49+mTu5J/4yZIvYDKsPgTIXW8vrvT2VvB2AZ9EoRdwDLIa9ux+Au5MdeDskOZ8omO7SKJr0
ARC-Seal: i=1; a=rsa-sha256; t=1523399635; cv=none;
        d=google.com; s=arc-20160816;
        b=nuVc/Ta9Gk0pXBYcJzpJxj0t+ZBck+6eSWHjpe8f36OiuqLtzExlG52dxd4tA/ce9g
         ENQ7M/gO2GXvrXxMzHG+0VHZ3Ak7Yn/JIwc98WfuqUqzBGjXSsEF85s8MTxzur0iyvL2
         xI+iIH7zHYgRfL9+j46ULQZhfvlRwviA6RcXTrDOq6FzLGNh1gV57EkRyqclQLO51HmP
         /O42i+CF7PyR1iCZy8SPiiIllGsycNJ6tc7AbSBsrhVlYkqNXx5iisI82/bRRuQZxsmw
         GuEw13jXjtXJTqGC8zgtsK4re6jwnUJnhyxxK4bTqgCXGMqTJ9tfD+oFv+9NMs7fduUJ
         56uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q4w6EhEtUcbmyopTXlsNjGVQYI2G5o27coycGzFbfd8=;
        b=EssJ49gvCDCPRmcheCWReD57q8Ejpj7/L5KV/adr7MFxb8hYozO7PqduGzMnbjEpKd
         G7X8Bt7bQbbIrqfQ8gsopnTDJeAT3nvkSNkMXtvazwYLDQ+umINlu1ca1W8a3nUvEFjP
         TjGWGSGWGpfsAhKHNbuFWRiK211lwqCPNoD69apBhs/FT1SxS109DClbixy+w9NF2r1t
         IDLXVSXTHZ8d/nj6okis3gvmX8XIp09dvH7JPxHXvuHApGK/Y2Wg8VFN7PScvN1+28Jy
         MBK5gehSLEE0AEhDcaWsgGzzSjIJqS3Zd/UfQVtJEufvcKiEmjNTHcB6QWCNI+auQuGS
         jKXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 002/138] i40iw: Correct Q1/XF object count equation
Date: Wed, 11 Apr 2018 00:23:12 +0200
Message-Id: <20180410212902.368192805@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399800260711493?=
X-GMAIL-MSGID: =?utf-8?q?1597400296524803641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit fe99afd1febd74e0ef1fed7e3283f09effe1f4f0 ]

Lower Inbound RDMA Read Queue (Q1) object count by a factor of 2
as it is incorrectly doubled. Also, round up Q1 and Transmit FIFO (XF)
object count to power of 2 to satisfy hardware requirement.

Fixes: 86dbcd0f12e9 ("i40iw: add file to handle cqp calls")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3875,8 +3875,10 @@ enum i40iw_status_code i40iw_config_fpm_
 		hmc_info->hmc_obj[I40IW_HMC_IW_APBVT_ENTRY].cnt = 1;
 		hmc_info->hmc_obj[I40IW_HMC_IW_MR].cnt = mrwanted;
 
-		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt = I40IW_MAX_WQ_ENTRIES * qpwanted;
-		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt = 4 * I40IW_MAX_IRD_SIZE * qpwanted;
+		hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt =
+			roundup_pow_of_two(I40IW_MAX_WQ_ENTRIES * qpwanted);
+		hmc_info->hmc_obj[I40IW_HMC_IW_Q1].cnt =
+			roundup_pow_of_two(2 * I40IW_MAX_IRD_SIZE * qpwanted);
 		hmc_info->hmc_obj[I40IW_HMC_IW_XFFL].cnt =
 			hmc_info->hmc_obj[I40IW_HMC_IW_XF].cnt / hmc_fpm_misc->xf_block_size;
 		hmc_info->hmc_obj[I40IW_HMC_IW_Q1FL].cnt =
