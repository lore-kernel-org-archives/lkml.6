Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoD2dut2ji5oaYkiuab+lcl9WdBGKOzABle8mMdO2AFQBSdUajnZ+rqrzCF7WQOgg7EUHum
ARC-Seal: i=1; a=rsa-sha256; t=1526631506; cv=none;
        d=google.com; s=arc-20160816;
        b=CNC8ZXa6FtzesevdhNje6CCoVXRgd19YAUOk1Sw+M9MoP+4cS/zFd6FUAe0Qs4e5pP
         Xe6MUFRcXWMEtqIWEyIqqlaI1y+5KcuHQS9uz3rw6LGC7n5QKrRRq+o6G40CckY5w8UI
         U1eS3Rs62eIpJGhx63C8eGh4lv0byyXS+OMk8JGRHl6HQnp8E2o/PQlnRrJoRIGxF+UN
         e6u3MxvUysth8MSYjbPYc34K2LhGiXjniQth9UfxCCP4r4FZQjSod7d+yX4RR2wSWab/
         4cL8yBtgaxCzA1rO4veEHJJc2zpTVzEcNZMJbVSR5rDCm9ozQY/uJHEhH/XnS7IeKR87
         dMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=oEvmKvYc+Fiulf7pB83+xTC6UrZ5aAhHpCUmA1kUwoc=;
        b=Dl8sXd+rmQVeO6rIn2yN6fidEvZDKnIiDOQ0SZkEEMZgoOAYiKP5DcXYwzAlV3gn/D
         w+s8Yr6fslj9enQGzyoKtO9nnPwDIDyBvH62f38sCPy/F6HQD5buX4AXcGgCvNFpvZpl
         MbqXRzrtkwxQqhtjMSfLSP4fp3uLlSHfr0+YjL3dQjnIZtZS1gkWj84CzqWAuvjLjEQc
         wnMT8v5jRgce1AjuqWUTLgtZbgaXHJ34syc77hgJUF4wxhqVmueFvVju53WvlBGGojL7
         MyYCqDpS5WYJ85I4Fr/Q16onTK1yje97NYsXa47md/vs6XKXhtWT+yadp82qjRSuCKIY
         s8WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qxF/z9C/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qxF/z9C/;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	John Hurley <john.hurley@netronome.com>,
	Jakub Kicinski <jakub.kicinski@netronome.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 44/55] nfp: flower: set tunnel ttl value to net default
Date: Fri, 18 May 2018 10:15:40 +0200
Message-Id: <20180518081459.505511475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789158968081367?=
X-GMAIL-MSGID: =?utf-8?q?1600789158968081367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit 50a5852a657f793a8482fe3af4a141b460d3499e ]

Firmware requires that the ttl value for an encapsulating ipv4 tunnel
header be included as an action field. Prior to the support of Geneve
tunnel encap (when ttl set was removed completely), ttl value was
extracted from the tunnel key. However, tests have shown that this can
still produce a ttl of 0.

Fix the issue by setting the namespace default value for each new tunnel.
Follow up patch for net-next will do a full route lookup.

Fixes: 3ca3059dc3a9 ("nfp: flower: compile Geneve encap actions")
Fixes: b27d6a95a70d ("nfp: compile flower vxlan tunnel set actions")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/action.c |   10 ++++++++--
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h   |    5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/action.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/action.c
@@ -183,17 +183,21 @@ static int
 nfp_fl_set_ipv4_udp_tun(struct nfp_fl_set_ipv4_udp_tun *set_tun,
 			const struct tc_action *action,
 			struct nfp_fl_pre_tunnel *pre_tun,
-			enum nfp_flower_tun_type tun_type)
+			enum nfp_flower_tun_type tun_type,
+			struct net_device *netdev)
 {
 	size_t act_size = sizeof(struct nfp_fl_set_ipv4_udp_tun);
 	struct ip_tunnel_info *ip_tun = tcf_tunnel_info(action);
 	u32 tmp_set_ip_tun_type_index = 0;
 	/* Currently support one pre-tunnel so index is always 0. */
 	int pretun_idx = 0;
+	struct net *net;
 
 	if (ip_tun->options_len)
 		return -EOPNOTSUPP;
 
+	net = dev_net(netdev);
+
 	set_tun->head.jump_id = NFP_FL_ACTION_OPCODE_SET_IPV4_TUNNEL;
 	set_tun->head.len_lw = act_size >> NFP_FL_LW_SIZ;
 
@@ -204,6 +208,7 @@ nfp_fl_set_ipv4_udp_tun(struct nfp_fl_se
 
 	set_tun->tun_type_index = cpu_to_be32(tmp_set_ip_tun_type_index);
 	set_tun->tun_id = ip_tun->key.tun_id;
+	set_tun->ttl = net->ipv4.sysctl_ip_default_ttl;
 
 	/* Complete pre_tunnel action. */
 	pre_tun->ipv4_dst = ip_tun->key.u.ipv4.dst;
@@ -511,7 +516,8 @@ nfp_flower_loop_action(const struct tc_a
 		*a_len += sizeof(struct nfp_fl_pre_tunnel);
 
 		set_tun = (void *)&nfp_fl->action_data[*a_len];
-		err = nfp_fl_set_ipv4_udp_tun(set_tun, a, pre_tun, *tun_type);
+		err = nfp_fl_set_ipv4_udp_tun(set_tun, a, pre_tun, *tun_type,
+					      netdev);
 		if (err)
 			return err;
 		*a_len += sizeof(struct nfp_fl_set_ipv4_udp_tun);
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.h
@@ -178,7 +178,10 @@ struct nfp_fl_set_ipv4_udp_tun {
 	__be16 reserved;
 	__be64 tun_id __packed;
 	__be32 tun_type_index;
-	__be32 extra[3];
+	__be16 reserved2;
+	u8 ttl;
+	u8 reserved3;
+	__be32 extra[2];
 };
 
 /* Metadata with L2 (1W/4B)
