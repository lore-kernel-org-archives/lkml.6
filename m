Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224ELs+0p4pcX9it9xf7xmC8KWIst72wwtQY7xPifUpNIxhKTq/UJJhlplH1s1PUro34Puql
ARC-Seal: i=1; a=rsa-sha256; t=1519410883; cv=none;
        d=google.com; s=arc-20160816;
        b=LTYeDkI3mwiHiyYmrfVOodEB5g/R+tJALThiD/aJhMPYTwzDgYQtjBibF0V7Ox045F
         AAahWvexeICh7mMBpgVvegLXYEoO8NTpjRYPIpsguccx8hYnnPlRT5tyccmh6Iqakzww
         BX+voHIW1JDc/MFr7awEHG4n8IBJTcRUtH+34fcX9YF6oVAZMHfihY/o2G+xFNWBzv6O
         J3lGA3mdj13wm4uIrpOnnTr1wfXUE2mxkRIzTSHSCwtUlT3JhElH101ACiANknTpkRGl
         XTpCl1DeE4a04fmoSIBUYt5GginU9KwdwIGscgd7Q2mcBr0VgjtW830+X6rq85OWJbBq
         cbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RSgNi3t4XwEZWrGUrSagR2+4rAp8NmwP8atHRZ5ooH8=;
        b=VMSIaAJqURRnEAk/8Dla1cL4PE+uP9d9NCAg0ppN+3aRjKFHzQH2ArKwJltid9s12o
         oRVMHVAY3YM984+cKH1WdXvogm1lKSKeM3GsR1+z4mknESMhfz4f6OULwTEW6BM1Vn96
         fhcd4ONfmqAOSbEXgYVYG2lbxFqphOgYNIRGxD4ZCszN68EgNEhIN3tjkVv4jRa5lu9K
         cZ+dZqCq1PrIXvswUmOs3nBhNct+EAVmN8gwhBnWViV99oybiPQBC+VNRUO4v34JbY5x
         TrGi16dlmrrORm3Ab6/+faEiy90ZkKzQB2LKWYoYFtF62vKhTh5XhuSUI0LWztTFchnM
         +NQg==
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
Subject: [PATCH 4.4 047/193] net_sched: red: Avoid illegal values
Date: Fri, 23 Feb 2018 19:24:40 +0100
Message-Id: <20180223170333.345774015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217657774423929?=
X-GMAIL-MSGID: =?utf-8?q?1593217787176944804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nogah Frankel <nogahf@mellanox.com>


[ Upstream commit 8afa10cbe281b10371fee5a87ab266e48d71a7f9 ]

Check the qmin & qmax values doesn't overflow for the given Wlog value.
Check that qmin <= qmax.

Fixes: a783474591f2 ("[PKT_SCHED]: Generic RED layer")
Signed-off-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/red.h     |   11 +++++++++++
 net/sched/sch_choke.c |    3 +++
 net/sched/sch_gred.c  |    3 +++
 net/sched/sch_red.c   |    2 ++
 net/sched/sch_sfq.c   |    3 +++
 5 files changed, 22 insertions(+)

--- a/include/net/red.h
+++ b/include/net/red.h
@@ -167,6 +167,17 @@ static inline void red_set_vars(struct r
 	v->qcount	= -1;
 }
 
+static inline bool red_check_params(u32 qth_min, u32 qth_max, u8 Wlog)
+{
+	if (fls(qth_min) + Wlog > 32)
+		return false;
+	if (fls(qth_max) + Wlog > 32)
+		return false;
+	if (qth_max < qth_min)
+		return false;
+	return true;
+}
+
 static inline void red_set_parms(struct red_parms *p,
 				 u32 qth_min, u32 qth_max, u8 Wlog, u8 Plog,
 				 u8 Scell_log, u8 *stab, u32 max_P)
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -438,6 +438,9 @@ static int choke_change(struct Qdisc *sc
 
 	ctl = nla_data(tb[TCA_CHOKE_PARMS]);
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (ctl->limit > CHOKE_MAX_QUEUE)
 		return -EINVAL;
 
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -389,6 +389,9 @@ static inline int gred_change_vq(struct
 	struct gred_sched *table = qdisc_priv(sch);
 	struct gred_sched_data *q = table->tab[dp];
 
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (!q) {
 		table->tab[dp] = q = *prealloc;
 		*prealloc = NULL;
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -199,6 +199,8 @@ static int red_change(struct Qdisc *sch,
 	max_P = tb[TCA_RED_MAX_P] ? nla_get_u32(tb[TCA_RED_MAX_P]) : 0;
 
 	ctl = nla_data(tb[TCA_RED_PARMS]);
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
 
 	if (ctl->limit > 0) {
 		child = fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -633,6 +633,9 @@ static int sfq_change(struct Qdisc *sch,
 	if (ctl->divisor &&
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
+	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
+					ctl_v1->Wlog))
+		return -EINVAL;
 	if (ctl_v1 && ctl_v1->qth_min) {
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
