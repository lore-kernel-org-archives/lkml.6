Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv516npW6ZYtegfv0eoWT9Io4GKHV1J6wsXa7bff2Diaww/jNzoqdxRh+y6K0HcSB7RPC5i
ARC-Seal: i=1; a=rsa-sha256; t=1521483763; cv=none;
        d=google.com; s=arc-20160816;
        b=QJ23UZR9oIquUeQ9JCQ3QiqGTkMkTMZ/gCkO3UUNyltaEzLb8joqyi31ACqLFPxEhx
         jYg3b5NLxnvccrwVY0j2U6jIt/poWlI7X/FQZUAZWmPrXZmZ1mB8uEu4eSG4/IMugtOJ
         R+0HbeTylzHELtUA6GGYIOhAbgyqJAQwTW9CFlZ0hN1psGnqycfpwSsAYa1Vumrk1oeU
         uYR5Df0pBOOiLWvYlcnDL9fxsL7SkehTfYmPCFkqQIAnoghzIZiAC+bWcfYwqCWFk+Eq
         j8eLaipaYrD5orxoc5xvC74Brl1bg6VDvcVngQ07+fuA9R8nuricziEmROAvyaUodNMh
         KzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8hF/Tz1wg9Qo6fBrgcZkWhLwiXzEvaTr3Y2Fwwve43s=;
        b=04RRGJqwfObGjmzM43UaHPbgp8kgAB//5uF8eZVShEYa0nV5bjuxzYiYfCGpMTjcnt
         GeCJ9EAy5HoPetLC01bqOmj93AFJdMP5Pl+yNa31EkXp7Hu7X5EhKfch7ZuP/s46OYiP
         EaUKrRqHAhQ6FzkTAcvU0tA4hWZstr4+lZJyjINXzrDGetPomTFRUJwl+Auc2LmusFHF
         bNjd482OI0Uu/ak90cUKieJw8Rgo6IwxCjvLMQn1tJskC5PGN94zSXry/i9Y/UXhgvxT
         aBzplkl5819O7HJ4fKjmarAIrxxIzMpPYh1E+pGK2m+APU75jeqZrSGmJoqk952xThkR
         tjBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Easwar Hariharan <easwar.hariharan@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 109/241] IB/hfi1: Check for QSFP presence before attempting reads
Date: Mon, 19 Mar 2018 19:06:14 +0100
Message-Id: <20180319180755.709719470@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391358986033648?=
X-GMAIL-MSGID: =?utf-8?q?1595391358986033648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Easwar Hariharan <easwar.hariharan@intel.com>


[ Upstream commit fb897ad315643e5dc1092a115b3cec914b66df9d ]

Attempting to read the status of a QSFP cable creates noise in the logs
and misses out on setting an appropriate Offline/Disabled Reason if the
cable is not plugged in. Check for this prior to attempting the read and
attendant retries.

Fixes: 673b975f1fba ("IB/hfi1: Add QSFP sanity pre-check")
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Easwar Hariharan <easwar.hariharan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/chip.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -9489,8 +9489,11 @@ static int test_qsfp_read(struct hfi1_pp
 	int ret;
 	u8 status;
 
-	/* report success if not a QSFP */
-	if (ppd->port_type != PORT_TYPE_QSFP)
+	/*
+	 * Report success if not a QSFP or, if it is a QSFP, but the cable is
+	 * not present
+	 */
+	if (ppd->port_type != PORT_TYPE_QSFP || !qsfp_mod_present(ppd))
 		return 0;
 
 	/* read byte 2, the status byte */
