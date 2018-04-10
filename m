Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/6np/xPBvntSFPHKGlgEw4rRi901Gt7t4TMfMqQxwDuitku8jnQW+HNcdKyE4tgXSViRTU
ARC-Seal: i=1; a=rsa-sha256; t=1523399900; cv=none;
        d=google.com; s=arc-20160816;
        b=OnFihCFqlMGQFTIgXDJE82VugVLUyIgnMb6Y/VW7TP2+/UEFu6sAXL+5FhOIqpsPC7
         42/exmdE+wtYbT5HeM1qGQf1ZZ36A8+Vr60fCu2Bi4rZiwIvi+wtharymPpyJjG+O3mM
         /2P71V86Zgug2F67Ntq3+GAlVcdnO3vsOoQ2F3ix8XMcXuoNlPvYqxSRhHE0dOKnt5Uc
         1/NdoY3SQPIZmAsneARL11vn69ZZqD8ZAXvuGUrtgCZTwzp8VlUgyF5TDbf3IOsTg14f
         V9KjJYC9d9WpkJdDGyFLJTr+QY18jywS9IOzNUxuHbGMb410E8IQI0LLYCnwQOsBDyg6
         7NcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ge3mPjeUEnq5PZlahWSwh0O3OWUO/Ydwu6X0MiS86vw=;
        b=dR1e+yJ0UzyUjT3p2LhX87ZFModSA2duvQ4KKI7E87QRKZayYTYvucQ2vKJQynlmUJ
         3aTp1CvfkPpeaGkjsZHflr9+nnQs2u3tdsc3nyStIHBovZjRXjYUrKVvvJGALr3UbH4f
         wgTKT9Qh+n3a+dNjbjbktlmeY/noi2hV9G49i6qnrJQ/wl/m2yv8g0Iq2i2WL7sd474k
         zgWJ+RQmMTMNLqe1WhUBGVwgkemXjBNUxr6bOil8DFxGe5gsgvf+ZQAvNydFh4o0m2QQ
         nGxKodjQ2LLbdp4brgIvpVU7MciUt9GjYO/w3v55b4uvYjvSdWikdTtQVMaHuN9Wa9ir
         aA/A==
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
Subject: [PATCH 4.14 104/138] net sched actions: fix dumping which requires several messages to user space
Date: Wed, 11 Apr 2018 00:24:54 +0200
Message-Id: <20180410212914.274790641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400153731397054?=
X-GMAIL-MSGID: =?utf-8?q?1597400574240219292?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -133,8 +133,10 @@ static int tcf_dump_walker(struct tcf_id
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
