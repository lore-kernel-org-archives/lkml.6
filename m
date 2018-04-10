Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+6yd61jG5LeqXIXwRRjMgse+nKmGVeSVU8N1Bf1xqsVz8jpq92b/i12ZPsaLogy4NrLBy4
ARC-Seal: i=1; a=rsa-sha256; t=1523399499; cv=none;
        d=google.com; s=arc-20160816;
        b=nRh4Bo4E0ePkpfc7pHOCIxemUS1U5eQleLBQaDj3aq48xtV0EmEP30aIvi0OANQPEF
         t2ry0y6AWrgjHu/kxk9jYexYCAwxvljyf4nCx4teRx9BnEzSGGeMuyuNxlY5ge/J8C5j
         gsuqng/lWYuZ9laHwHwTdyj/+dY1KtOtU25MX1qWjlTI/NhhC8JjShPDsBBbS5aGqOup
         mmTJi2/0oRsccvohXuVQEV8fTZz9CLc0D6i+BB9B69yM5iEDWHUgiwSA53hzQf29Cb5J
         Wi+RLDBpP75K5KhadSxMCYUpH8+aY+WFX95pvJP7Ovap6e9eIEKWGUiQjsmQkezLuQN2
         1vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pr4purGuqh4BX01NC4v6M54BNu7zRGNIGJ8H8iqhE7o=;
        b=oeFwczqt5BkCkmUfMW9apU+5Yj2NFJDfvevzUPxawWBqSG55G1RFJDcpkcDI1vV+Nw
         73R2jH+G7gW5/EN137Pgw75A3Ths0aXyHHT/+XHDI9Qc99AP1+PfkwBqecvjU7oM3DYF
         /0A7yM/krVscr9YsRp0dv8e8Hagf9iZ5R5zKSPd/0umq6APRJ5jCvntsHLEeB/vLaXWX
         aK3MFiskJh/3l2lhCHktf2LDOjJnlfz8kExMAdfyRBlUa93vXxlg0vL2f8MvgZUSyQT+
         gObb05Ut/vtW6Gonetn4djC6GRIxPOv/00Pk/wyB1uk5zxsdxvGTJLHtDfNSK4P9moKJ
         Fm0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Craig Dillabaugh <cdillaba@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 130/168] net sched actions: fix dumping which requires several messages to user space
Date: Wed, 11 Apr 2018 00:24:32 +0200
Message-Id: <20180410212806.332168763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400153731397054?=
X-GMAIL-MSGID: =?utf-8?q?1597400153731397054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Craig Dillabaugh <cdillaba@mojatatu.com>


[ Upstream commit 734549eb550c0c720bc89e50501f1b1e98cdd841 ]

Fixes a bug in the tcf_dump_walker function that can cause some actions
to not be reported when dumping a large number of actions. This issue
became more aggrevated when cookies feature was added. In particular
this issue is manifest when large cookie values are assigned to the
actions and when enough actions are created that the resulting table
must be dumped in multiple batches.

The number of actions returned in each batch is limited by the total
number of actions and the memory buffer size.  With small cookies
the numeric limit is reached before the buffer size limit, which avoids
the code path triggering this bug. When large cookies are used buffer
fills before the numeric limit, and the erroneous code path is hit.

For example after creating 32 csum actions with the cookie
aaaabbbbccccdddd

$ tc actions ls action csum
total acts 26

    action order 0: csum (tcp) action continue
    index 1 ref 1 bind 0
    cookie aaaabbbbccccdddd

    .....

    action order 25: csum (tcp) action continue
    index 26 ref 1 bind 0
    cookie aaaabbbbccccdddd
total acts 6

    action order 0: csum (tcp) action continue
    index 28 ref 1 bind 0
    cookie aaaabbbbccccdddd

    ......

    action order 5: csum (tcp) action continue
    index 32 ref 1 bind 0
    cookie aaaabbbbccccdddd

Note that the action with index 27 is omitted from the report.

Fixes: 4b3550ef530c ("[NET_SCHED]: Use nla_nest_start/nla_nest_end")"
Signed-off-by: Craig Dillabaugh <cdillaba@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_api.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -135,8 +135,10 @@ static int tcf_dump_walker(struct tcf_id
 			continue;
 
 		nest = nla_nest_start(skb, n_i);
-		if (!nest)
+		if (!nest) {
+			index--;
 			goto nla_put_failure;
+		}
 		err = tcf_action_dump_1(skb, p, 0, 0);
 		if (err < 0) {
 			index--;
