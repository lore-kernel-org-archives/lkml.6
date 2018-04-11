Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/7+1m6BcMXxBbdWn43h0UCrrRGd0a7sk24JChNdiG4lTATh7BLtyMj2yw6F9OvAP+5C1hM
ARC-Seal: i=1; a=rsa-sha256; t=1523472724; cv=none;
        d=google.com; s=arc-20160816;
        b=A2fvS3idelF0NhzU9qeJpDhbhpZt4gg0w2zy4zk1r0YUoWJxE+2yW9QpNm9fF/B2Wd
         aoqyvdGpytLO+rOLd7uIKFWMvHsnOpuxXBSx3NmkWWndgx8PyU1lWAeJ8p2ChYK8RRUq
         UBpWHcXatG8ENzOAxpHVobZHWL4p20Li78wbJGr9ZhSOrqbwpINzRB0SPNTpuYwzTM49
         NXza1J3gUwYIYlX57+qT5DW/YVxG13BNmFKg5R8ma+25glZrh0DahPQ7cz72rFyJv4wx
         9u5BwSXDbZZDMQPiOFhftM9+fgIZEgj4ePrpzYhr9H9gQG/A7zA5hKILuaVsi6eCGL8/
         4gCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OJUtpGCGTdUHUht3lnAhRKQ9HKP+OTVIIyX6jy8mB1o=;
        b=D57kxYmsy8yA/yt4eEbz8eY2m0jbL/upJHSR04PW930p1yk4bLPUbb0b1U3qRTG6Dn
         FTdzpZne+/Sdz8mO62ujOt++4e7Dat3ooCEWWaF/UyUZ2JPWeykNvUgZuFb/t47uXvu+
         9//Vi8aHVCC+DTVqa3TKT6ol/qe5tEZcKtIsY6z5sxlbTRsDQWEXNBcFsmCnz+jSeq3c
         CmgQsMpRPPqJEwRaxy/Az7xDbH4s4FQe3iqepgGmpM+h8uz+gwFEU4gHyp/mh//RMLI7
         kVp1fn5rKW1R7WDK+ee9DMARB5lcdo2E3LoJggTHgdMiMpiyLKfrgSyOAhzOm6Fow1pG
         FzRQ==
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
Subject: [PATCH 4.4 187/190] net sched actions: fix dumping which requires several messages to user space
Date: Wed, 11 Apr 2018 20:37:13 +0200
Message-Id: <20180411183604.489850959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476380426515684?=
X-GMAIL-MSGID: =?utf-8?q?1597476935053327626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -101,8 +101,10 @@ static int tcf_dump_walker(struct sk_buf
 			a->order = n_i;
 
 			nest = nla_nest_start(skb, a->order);
-			if (nest == NULL)
+			if (nest == NULL) {
+				index--;
 				goto nla_put_failure;
+			}
 			err = tcf_action_dump_1(skb, a, 0, 0);
 			if (err < 0) {
 				index--;
