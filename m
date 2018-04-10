Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+hIUYK7em0msM3ZJtblg4d8Hexho0bdEb+bJiM2NzXiYix2lMAxhhDXeC12nNrU2/Q8y08
ARC-Seal: i=1; a=rsa-sha256; t=1523399162; cv=none;
        d=google.com; s=arc-20160816;
        b=UGlyKJjyt7b7Wjug3oKeJhxok3BcYcH34IH7dVJyAD6F0g1KharppJ+W/KQOLBYQa4
         ir7ctkHWEHiHBQiOOP7QhvCxPdA0cY9mfh3vsqbljOk4DmWppmJBn97bbnnD8UknBXSm
         h2Gq6kTLgJzOgqgIBpf2RY1NBr+B7UU+JBIHKSpt+6scuZU7Eb7I0VqOhbROedsIDyJj
         b4JZY7mbGnaDvFvpVJxawG2M/mWamVkEvcBCjap8ztDfOoso48xSLe+ObfPVatykh7Q2
         Eu6ghp0kQ3zrKkgjnlccTRNaCxw7ah9U5bI1JoKc0/QIfhIbmsj+gXSrqEIpcbLMaU5g
         MG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RIjIfh79uVlraAcCw1YqfZmWh51pyKdpDRXq6GUwchA=;
        b=NobAFlOVyEdzxEqQQ7CcCkxvAh3WzkD32iR3owV1ZoY44hHFuPKirqimJO55nrHpyV
         e+MseigJ+4NNX0fq3ZXnEhX14Ztjy+V66D+Izif6DennR2dsimf+G6I0AdVWhkAEJlkE
         9gLpwh8quTZGCZ2FlgHR/JcmXUYCK78SjzH32m6BvemwTxa98lyM+KQBA7gWnyierK6k
         r+xqLJFOp6q5f9b0BWNtsAcaXJ2+YtSDZhJAIc9pqNNmliCen+PwoK5KzQE42F7b9tWX
         WfACDVVgAU4AN5xZkx/99ooL0S3oObcogtef35Cv7vCt0uJu9xmElrCNJMbRzYPgeOT2
         khXQ==
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
Subject: [PATCH 4.15 002/168] i40iw: Correct Q1/XF object count equation
Date: Wed, 11 Apr 2018 00:22:24 +0200
Message-Id: <20180410212800.272140523@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399800260711493?=
X-GMAIL-MSGID: =?utf-8?q?1597399800260711493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3928,8 +3928,10 @@ enum i40iw_status_code i40iw_config_fpm_
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
