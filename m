Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227/Jacs+V79QGjhdT5nBWBBS8ZsmuilYpwWALbJm+9WaFcOc07eJiadBgKFD+k9vt066oEu
ARC-Seal: i=1; a=rsa-sha256; t=1517591045; cv=none;
        d=google.com; s=arc-20160816;
        b=UVOjDCW0o6/5kd2V+PeijgMSiPMou5DlT8RF1Di9d3fQjuhss/U2YNMKij9lJ8GqNQ
         T1pScLw/NXMlOps8MJmmhgU7eCfPPn5qPCRTf0hmL6e9kfZ8BOjeqMKBI+c0QUpa7pOO
         2BQB7pg5ok5VGYAQL9/dbqyyUcLGk8LENTLNl/il9z8bFAieQLC29sH8ZmOUpHvjnFKE
         4OzVnFSuJYfWXLNInR/ONBUjC2z2Yb6pInxuW/9IE2Gg/dD11nlqg980KpNRirOlTg/V
         6Cdk6zIsIl09PTqYjUHNeMeWgsKlKYz6YLFtUOaulMjc1BGypKpVGpbySI6tAHj0n0Xr
         teFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nt3ApN0cms1XUMu8ZvkbpE8scof0HY8wwZISr0T5TJI=;
        b=mSG7ad76SF6+ycfPIGzEsYikSPdRMw2zj4bMWqNA+Ydv4hjPy0RJN/lpN2Ul2fRoQd
         0AIwsRyJAlRbHz/GjNq2GgvtAdVCqd6Ej0j51Auk4uUTT9qoWnhLkU0aiaENS+TO6uwj
         E8NsrXeln/2gl8DRYkd9Z4vE/Ttt9nrfylbky93P4Fij/HkT0reAsRYNdUCiv9JP7Zj1
         7SiqSn6D5C7kp20GcwV9WVX+DYIOTz00/KMWn/sZRSBWnyQT37r/lqiRJOruw7ndaxOv
         v0fSKRLoQkd8cr7PVjqvStx1qiKXO0bmzcSDUxI3aAWy3oObWHCoiC3Gce5I1zHRQa1t
         EgCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	zhangliping <zhangliping02@baidu.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 32/86] openvswitch: fix the incorrect flow action alloc size
Date: Fri,  2 Feb 2018 17:57:52 +0100
Message-Id: <20180202140825.515335098@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309440466485315?=
X-GMAIL-MSGID: =?utf-8?q?1591309548248341623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangliping <zhangliping02@baidu.com>


[ Upstream commit 67c8d22a73128ff910e2287567132530abcf5b71 ]

If we want to add a datapath flow, which has more than 500 vxlan outputs'
action, we will get the following error reports:
  openvswitch: netlink: Flow action size 32832 bytes exceeds max
  openvswitch: netlink: Flow action size 32832 bytes exceeds max
  openvswitch: netlink: Actions may not be safe on all matching packets
  ... ...

It seems that we can simply enlarge the MAX_ACTIONS_BUFSIZE to fix it, but
this is not the root cause. For example, for a vxlan output action, we need
about 60 bytes for the nlattr, but after it is converted to the flow
action, it only occupies 24 bytes. This means that we can still support
more than 1000 vxlan output actions for a single datapath flow under the
the current 32k max limitation.

So even if the nla_len(attr) is larger than MAX_ACTIONS_BUFSIZE, we
shouldn't report EINVAL and keep it move on, as the judgement can be
done by the reserve_sfa_size.

Signed-off-by: zhangliping <zhangliping02@baidu.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1789,14 +1789,11 @@ int ovs_nla_put_mask(const struct sw_flo
 
 #define MAX_ACTIONS_BUFSIZE	(32 * 1024)
 
-static struct sw_flow_actions *nla_alloc_flow_actions(int size, bool log)
+static struct sw_flow_actions *nla_alloc_flow_actions(int size)
 {
 	struct sw_flow_actions *sfa;
 
-	if (size > MAX_ACTIONS_BUFSIZE) {
-		OVS_NLERR(log, "Flow action size %u bytes exceeds max", size);
-		return ERR_PTR(-EINVAL);
-	}
+	WARN_ON_ONCE(size > MAX_ACTIONS_BUFSIZE);
 
 	sfa = kmalloc(sizeof(*sfa) + size, GFP_KERNEL);
 	if (!sfa)
@@ -1869,12 +1866,15 @@ static struct nlattr *reserve_sfa_size(s
 	new_acts_size = ksize(*sfa) * 2;
 
 	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
-		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size)
+		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
+			OVS_NLERR(log, "Flow action size exceeds max %u",
+				  MAX_ACTIONS_BUFSIZE);
 			return ERR_PTR(-EMSGSIZE);
+		}
 		new_acts_size = MAX_ACTIONS_BUFSIZE;
 	}
 
-	acts = nla_alloc_flow_actions(new_acts_size, log);
+	acts = nla_alloc_flow_actions(new_acts_size);
 	if (IS_ERR(acts))
 		return (void *)acts;
 
@@ -2500,7 +2500,7 @@ int ovs_nla_copy_actions(struct net *net
 {
 	int err;
 
-	*sfa = nla_alloc_flow_actions(nla_len(attr), log);
+	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
