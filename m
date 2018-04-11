Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+va97DcRvWZ2eVPDDQP4am2ad/+QapVgAdPU7gOgjG4IGSoC7+Xmq7nZTkyKJ1R/PxpkTk
ARC-Seal: i=1; a=rsa-sha256; t=1523473275; cv=none;
        d=google.com; s=arc-20160816;
        b=ol79LtM/6U+A4KR2nKN4WnZUPqstOMP7AqP8qMMt9Cjy6LB66fANd11Yg/JfVWUF2T
         29Co9SbGiHzZj1sFK0ggSYfFifFEsr3Wj3EE0kz3DQotD2vaUwMeHGUb74ad7/dmIQFQ
         39kpCLwPtHcroSVZ+3jBW6MaVAjSkDMB9btfD/v4DWnQFayGxY3KP+JCj/wNd0fBH5m9
         bINUIii9lgPMhg9kiF2+tyK9Y966npXSLnPdpNgn+y0uELXOenB/BsteyuGjqDruJlLu
         eYOfT6DCZsSxAuTl7QmRVfyFExWNkJcPg+O/VtCnh4B6GJGPx1yOH0Su8fiQFpH/FP/r
         a09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vPmlW3WrPFpXj51fnDDxcwaEJFEikLHhBpa9Pdosjkk=;
        b=G8M58UuTA2Nz8NisX+GQYv+YzQRgSgejD1kYQnaSs7k45zUzQzMDKo2AZBZaRvT5+n
         gHihKiI08HyWNKJsDcP0BfhSllzrO2kapmtXMP96CFkLpazRL2EEtr65skMjfkp02kzB
         6FmPA82zLoElgtHs1u5umDGj+U1HEVhxERlTo2Usfqimgn0PyU/Do9vCxuDARZnCDVTZ
         4ZUqorcitJvEMofbY12gFS47jBoNjdGzkScZXwt9mRHmqxJGAHEsHu09uKuhAyBm/u4P
         D5qzq0AyGaUTeSjef2vNpwEJjcEg0l5uLqkE2jabDgHy+bHysWoj41niaHhbTXtWAk7N
         TxbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liam McBirnie <liam.mcbirnie@boeing.com>,
	Peter Dawson <peter.a.dawson@boeing.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 189/310] ip6_tunnel: fix traffic class routing for tunnels
Date: Wed, 11 Apr 2018 20:35:28 +0200
Message-Id: <20180411183630.735021529@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477513128182524?=
X-GMAIL-MSGID: =?utf-8?q?1597477513128182524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam McBirnie <mcbirnie.l@gmail.com>


[ Upstream commit 5f733ee68f9a4df94775299ac6a7ab260704f6ed ]

ip6_route_output() requires that the flowlabel contains the traffic
class for policy routing.

Commit 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on
encapsulated packets") removed the code which previously added the
traffic class to the flowlabel.

The traffic class is added here because only route lookup needs the
flowlabel to contain the traffic class.

Fixes: 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on encapsulated packets")
Signed-off-by: Liam McBirnie <liam.mcbirnie@boeing.com>
Acked-by: Peter Dawson <peter.a.dawson@boeing.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1097,6 +1097,9 @@ int ip6_tnl_xmit(struct sk_buff *skb, st
 
 	if (!dst) {
 route_lookup:
+		/* add dsfield to flowlabel for route lookup */
+		fl6->flowlabel = ip6_make_flowinfo(dsfield, fl6->flowlabel);
+
 		dst = ip6_route_output(net, NULL, fl6);
 
 		if (dst->error)
