Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPQIqC50jlSPzaMgPLE3eJ1MTk42B8i1YSP0WYAlQCfRq2wZWZK9idrmlpA8SKND5vDWJv
ARC-Seal: i=1; a=rsa-sha256; t=1519981454; cv=none;
        d=google.com; s=arc-20160816;
        b=hOvc2GJ81RjuxgNEh03nhLMcyJbOlkpIRsUqLwNfX8865Fde0EWLglJG0y7c/SW2M6
         FzcJZTv+NGevDarWbp9jZlWsbs1B341z5RRmp7Nf55LXEnnsKdWQ7vkKst3rmm03EPGB
         CBrggvccT3CYTau8CTpzUpmoprE6B8WjoR44qDtVk0lw/aiU1y5vExLWPnL+Q7NJlAc7
         g1bx/O5Bv2fip9lCWhvIHvS4BBnlRcDNZINhKq9sl4dCPz1S+PlPs3ZOixb3IuWhDdOH
         IlxLhkNKRQfSox5tRPZwehYWZf7Bwm90YJ5LCgvXbtDjVxdqWJAzOUfGIZ92wy8TZQj7
         66cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vvgd7vlLkIim8SGgA/I7KS803N+iuDNF9XMHyB/KRvM=;
        b=sNR3T4EWMt7oLWRAhxwi7Zoc6CfMjAh7EIDuxBRZaBhDcUEwBABcPwYn3zWfKa7shI
         IAmfORp6SJHiLWijc8KKxBAnht+jYbAON+cei+X14bGxu3pVkXPoaEruAPpVtBX8ddwG
         6G2V+fGZ/AqCTzFZ4xQdDDUhiA97i7cvJ3997IINsgFs2mjXPwB3SO8qpLcP2/7RP5RI
         eQc08L+oTDyXNNR1aQOuzcXyE6dj6QX4TKHPSTyAPUCtI4RsnB1ct3MoN0t5+LdlfyjM
         6h4gFPC6SndzlQjl7SeXiEdOkwTYtuXlu7nS5P0HP4JyatrG+uEowpM8dhEdb7yzFrER
         gN1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sunil Challa <sunilkumar.challa@broadcom.com>,
	Sathya Perla <sathya.perla@broadcom.com>,
	Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 095/115] bnxt_en: Fix population of flow_type in bnxt_hwrm_cfa_flow_alloc()
Date: Fri,  2 Mar 2018 09:51:38 +0100
Message-Id: <20180302084507.683630736@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816074409761267?=
X-GMAIL-MSGID: =?utf-8?q?1593816074409761267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil Challa <sunilkumar.challa@broadcom.com>


[ Upstream commit 7deea450eb912f269d999de62c8ab922d1461748 ]

flow_type in HWRM_FLOW_ALLOC is not being populated correctly due to
incorrect passing of pointer and size of l3_mask argument of is_wildcard().
Fixed this.

Fixes: db1d36a27324 ("bnxt_en: add TC flower offload flow_alloc/free FW cmds")
Signed-off-by: Sunil Challa <sunilkumar.challa@broadcom.com>
Reviewed-by: Sathya Perla <sathya.perla@broadcom.com>
Reviewed-by: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -327,7 +327,7 @@ static int bnxt_hwrm_cfa_flow_alloc(stru
 	}
 
 	/* If all IP and L4 fields are wildcarded then this is an L2 flow */
-	if (is_wildcard(&l3_mask, sizeof(l3_mask)) &&
+	if (is_wildcard(l3_mask, sizeof(*l3_mask)) &&
 	    is_wildcard(&flow->l4_mask, sizeof(flow->l4_mask))) {
 		flow_flags |= CFA_FLOW_ALLOC_REQ_FLAGS_FLOWTYPE_L2;
 	} else {
