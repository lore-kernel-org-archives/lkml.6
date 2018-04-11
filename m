Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nOrhHC9Wm9OPEYl1prenNXPUa9ltwYkRIqHpCg9Dm/hdEfTtsRFOZ3PJ0HuzWbLtrs18d
ARC-Seal: i=1; a=rsa-sha256; t=1523472195; cv=none;
        d=google.com; s=arc-20160816;
        b=NGXf/sVAxDGmufelzA4lY8jdyVHmd4ZW7mqvYZwVdDWX+KOGqrv9LYN+qQUqXeWCOa
         RQ/hHPa1FbYg31T8grpuJ9NhtCQ8DnAYmUL27A8lsuoJAv838h5porqeUBjb0hi6zgJ0
         /TBGfN9xA/VKkqMF1hFwry9dV+Dfjksctdqb3kjLgCCoeoNnjE8jTIn7Qi7KvQBgtlAY
         bS8ipbqZ97j+no3Za6cdCg7hvg8fvb0yupcoiGXkp2jTyx2BzG5EzdinZH8cmIQLW1uc
         U3JSM5BXoig6wwH0Wj2pdiYM5bMSbFWq1AWZSsKzGVgghSKGFtQ/2IZMIRIYnGLpWz5Z
         LIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rDu/wKV0uK7eGNwlJz23snx9UQM2HZX8PzzU9ve7VMI=;
        b=CAuZe3on2IJdCfcEJXKPNCkSiI+XKX66wpWT/yBBG3PLP66eZTq62TTd1jT/k+qAOR
         DFGj4HlGib+8MOIRMmJ9Z14VH2YVhn4SA7FUd9p/6U7VwL6Kl4+k1qX8QLEfbi1UnDuF
         /g8klCqrOY/KZm2y5EBAZ+MJbgbt0fOlKYVpX2/J67xoGS/T1j6umzZ8VTQn5nf9kKVI
         Sc6CHxIqGQC8yJczDOf6ZxMjXIvrKr3Aln45Qp8o1FKRvIpCkcPGmFtydTfSw61sKWlE
         6SA1BjMlJmJpGzmvTzbCGycXoYMMHSGLPoWfpm02SedW97Snr2s3XZ7kqf+T1aVt1Yz3
         z/uw==
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
Subject: [PATCH 3.18 120/121] net sched actions: fix dumping which requires several messages to user space
Date: Wed, 11 Apr 2018 20:37:03 +0200
Message-Id: <20180411183504.291078700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476380426515684?=
X-GMAIL-MSGID: =?utf-8?q?1597476380426515684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -92,8 +92,10 @@ static int tcf_dump_walker(struct sk_buf
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
