Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XNTissWtCkk5EeCttbWqwWceJjtckmuSxHRLOSrBUwtmZj/6pARSAX/t9Als/RUlH/+Ra
ARC-Seal: i=1; a=rsa-sha256; t=1517590943; cv=none;
        d=google.com; s=arc-20160816;
        b=uq38Oxd+bO8etCHvONEC5fnhF2oJ/A1iKJtdysBiNEQ8a/afpSUXz5JbrRX6gJw+7F
         +iCut1sAWdMjWcWAGx2Wk+WoVU6gl3gjnxeutmJZuIflLe8v8/WFqhsgN3X+v9xq/nc5
         PWFF/cE1XfwIplrlZ7Ifx5L5w9Zxp3VVYl0YhztDuODXZtqhmXxbyZ9TEGhWhSVMQfR1
         L7oPKcrufGYrmeA76LTjfyRkAV310NDBFbr9D1R1diwYpSNhzdWpG/8Pef8ZOWlYlUTj
         W5LT6sKQXLYKU3+UNyo3R0Hot4Rdc8BJRsmYjNHIGTgPm9NWAo90Qkyekb2rhgcLphHI
         bp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ou7ftDabgV/Zh+gSfIWqYFk7ozQ5de00s0vDmMm3bvA=;
        b=IhSfUpCkT9Jp6WUd7WKW0sgcTwnHzV2klgDZkEGlR6fhHfxUrOYLe+rwUc1paJ2pbP
         d53ua8vaJKUMo2Fgp8O7yluMExva5yZASzoBhCNyk4401ViTz/UFFZDCWGx2DF4WV4EZ
         arlkjVeAbsXj3iq2t8jZN6kv2/Y/8a/Bx9pAIxtUrdA3rEO258UcHnQd8DAeLCuRFdd3
         XII0ExmMxaLO1C42HJJ/I3jY72zrHZmiwmsWpWorrt//qvaDcLLvzqxIx5WSr7AQtSn3
         r6tfkyzIB3a3eKpgxT1eYC9UauLO6yAr+EsKZU2hVEyiW6Ue7yPbUYZxUhNGiU0UuFGl
         9H7A==
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
Subject: [PATCH 4.4 33/67] openvswitch: fix the incorrect flow action alloc size
Date: Fri,  2 Feb 2018 17:58:02 +0100
Message-Id: <20180202140819.318783523@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309440466485315?=
X-GMAIL-MSGID: =?utf-8?q?1591309440466485315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1672,14 +1672,11 @@ int ovs_nla_put_mask(const struct sw_flo
 
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
@@ -1752,12 +1749,15 @@ static struct nlattr *reserve_sfa_size(s
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
 
@@ -2369,7 +2369,7 @@ int ovs_nla_copy_actions(struct net *net
 {
 	int err;
 
-	*sfa = nla_alloc_flow_actions(nla_len(attr), log);
+	*sfa = nla_alloc_flow_actions(min(nla_len(attr), MAX_ACTIONS_BUFSIZE));
 	if (IS_ERR(*sfa))
 		return PTR_ERR(*sfa);
 
