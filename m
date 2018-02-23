Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WTAESHBwZPnHNxbyRc4HGt3Fh8KNNzP2+O2v5/xV/wHKcjScgwAK+9P9HF7tKnqRn4OnI
ARC-Seal: i=1; a=rsa-sha256; t=1519410880; cv=none;
        d=google.com; s=arc-20160816;
        b=YsiKE08V8gRgzSrX9J4l560hSQi5tP01rWgS754NC0oFyqIDByAhL7lkkuHAdnGKoW
         RqSiJgZG6+dTe5jdegKrpGSOl1ZXUf6ci45PsR6MoriEc5LgxdSbYqIrvx3xLIp9+9we
         iNHXd/tWef9b967oqY/C+jYxEdAGSIvs/VCeVqYeEMWtZm+blUxCYAqXInDh4p/ZVoQr
         0klaQzR2W9KH527bCVBTML1sj9C6h3mzurXMet8+L8Gbh20TPT7c0U1bABijd2yQ5EVZ
         qneaCLTC9jtPoOgGjw5rzcf76tQfqid9S5AmCVFJbDm108h7h6zRJLLWFSxogWQvpMlu
         JM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FfvpNii41fTPEOG8WUURA38N1GKIQm3rzoefju1FNJg=;
        b=hIfFa98o0EqOm/aK3QjA+pqwoM1QDsXkdXzNlyuyb/nVRtKsRwYZWfPr1CvHU7XZ+O
         7bce7W2f4GBC8z7FnmKEGFvKqWnFOlJ06ktGoLg39e+daOGAgk+9rhE3S/pq7opWn4Y2
         VleueKofEtyLuwdjdpSoBebuaPVsMxv8VOBQvrlSIGWyBm8bx+S0gO5WnbElNp4k2YS2
         fteFPCRreMojcuZ85mvidsvhuXkXPDdxnAjgSlSuxBNJW3XIyqG6T1XPnaFHtVwwIpiE
         O8bXlZFJxQ+ix78YYcutCuIlMGRsUbpaYvVqb9C+HmRd2zFyL9C6E0txplc7CZxyYf3h
         LqBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nogah Frankel <nogahf@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 046/193] net_sched: red: Avoid devision by zero
Date: Fri, 23 Feb 2018 19:24:39 +0100
Message-Id: <20180223170333.192593572@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217654339528451?=
X-GMAIL-MSGID: =?utf-8?q?1593217783847025936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 5c472203421ab4f928aa1ae9e1dbcfdd80324148 ]

Do not allow delta value to be zero since it is used as a divisor.

Fixes: 8af2a218de38 ("sch_red: Adaptative RED AQM")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -178,7 +178,7 @@ static inline void red_set_parms(struct
 	p->qth_max	= qth_max << Wlog;
 	p->Wlog		= Wlog;
 	p->Plog		= Plog;
-	if (delta < 0)
+	if (delta <= 0)
 		delta = 1;
 	p->qth_delta	= delta;
 	if (!max_P) {
