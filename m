Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujPwXjl2RalTW96iYlahgK9oEFZU4SY3ic1Si75vgy5srthUynSYlkLmPN8rQZ/u4/VR/5
ARC-Seal: i=1; a=rsa-sha256; t=1521800172; cv=none;
        d=google.com; s=arc-20160816;
        b=a8yXgglf+G14usZw7+1PTF6pkV8y27y8FO7x8gBenORkYINidjLbA7OOPxGLKxiCV2
         e8zUw4ZVeatiliocXu/l3tr0SEjf3w0ci+DGZVIFvG5yprdJ769LinyZlTurNcXfhBl3
         63KDQcvzk2Q1tjcPK+uQiax4Z8vsk9thvacNo3WDQ1hdZzbnYrGzmR2S1Co0yKEYnQDq
         ZZiT6SA8A8ujXBYnFeULSKdSA5TyVnUhO7Jv8pKSEMqjlMktF6t5glfqe1U3bYMrUXbJ
         D+K+hU/5SX5Ob7j/VqMFV8gnWhcUgc90hWCWoHARHgnLxLBoP4xly3V7IzMdwlvV57BS
         20lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K9sY9KK9GqM2TRt+8gJlb05elZ14Re7mHWXL0zQO1gk=;
        b=LrjUk5If15c2mZWFoMVbuqDuEbwrFSTuGAwxHvrJV2pYrYevztofvTr2D2dqAD75Xz
         yUQmQ571PuHjLzBLK14V2ohqlMwqjQzHJyAwVItzt6G2pEyoZN9jJDAe4yc/FCl6P+6v
         oR8iWjXnuULDtsbF7AOQh2VUUi/RtlhxuaS88RZUJyuU3Dp7Ds1TJDRXert+tOxONPi+
         Bv7LHOJP9uABAc85TSK0+IMzxBB7A6Tk0DpMrlEWsmVNcunnwERzQ3xdZ9FuffbonhpQ
         UiCLsF2YKswabqMiFAA6z6+bQ+z6sb+7wXnVeaBaIUJY8WN7629KmOwSa7sI2AFpHM0N
         2deg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 74/97] media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe_timer_interrupt
Date: Fri, 23 Mar 2018 10:55:01 +0100
Message-Id: <20180323094201.738568591@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721901866186978?=
X-GMAIL-MSGID: =?utf-8?q?1595723138003289240?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit baed3c4bc4c13de93e0dba0a26d601411ebcb389 ]

_channel_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference. Fix this by moving the pointer dereference
after _channel_ has been null checked.

This issue was detected with the help of Coccinelle.

Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -83,7 +83,7 @@ static void c8sectpfe_timer_interrupt(un
 static void channel_swdemux_tsklet(unsigned long data)
 {
 	struct channel_info *channel = (struct channel_info *)data;
-	struct c8sectpfei *fei = channel->fei;
+	struct c8sectpfei *fei;
 	unsigned long wp, rp;
 	int pos, num_packets, n, size;
 	u8 *buf;
@@ -91,6 +91,8 @@ static void channel_swdemux_tsklet(unsig
 	if (unlikely(!channel || !channel->irec))
 		return;
 
+	fei = channel->fei;
+
 	wp = readl(channel->irec + DMA_PRDS_BUSWP_TP(0));
 	rp = readl(channel->irec + DMA_PRDS_BUSRP_TP(0));
 
