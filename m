Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226XDuaZhefT++fx1ribRGV470wdo4yX+J4zDWQVM27XMcdLcHaCmmLALiCL2XEhcR9ppCbd
ARC-Seal: i=1; a=rsa-sha256; t=1519410856; cv=none;
        d=google.com; s=arc-20160816;
        b=c/L/MVegzKQqJNSN1O5uI8ri59N2p3oFrVXyB+C9rZ+Rdy2oUrvJS50va8VPsS7pdR
         mw6hAW9vI4fsqCVoFEx0Z/eiE3lUe7pPZi11bkhuizROTBwQok9zY2G5x005s9PyjQm5
         nIn/MByoVz49zAhT4mBPZHjGJJE+YL4nTXyYiOjfmde8V3D3bEoDDVKQt65vHQBLH35T
         2CZwj3GoloBec5rWQf3pnwOowbywWzEamgyTdgPiXdttNE8gpuKsab+IFMdbZzOb/TfU
         zg6qq6qCPN/B5eSW2xE9KYmxjWXLFd55s+k+LIiA//gknPfHHNSbs2+eGWZUpHeKklzr
         fiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OJE5esd8rPvcwEwAX/xuIi4gftqcmm2TCJxuxNazbuQ=;
        b=bFD3EbT3WxftFk5sznBR4nluWeroMuEquFJYeEGHYFYIqiievH6NQu+HQZzf7QNorf
         UAGhBC5H/FyljUNYknhh+OkKcCckxzFIDSPU/MKNNPHMC26ZFtIiXp5fzhn0I0uDdEgk
         XesuMPsQ09+oGLwaaBOPb/z/Vkr6bnW4w5k4DekGfm7nCIeIByE+g1q+ntOaOCKtYXe8
         gTWm+n498e7Bk0mhHpjmtlB/n9Y4pIs31mUV7HXQGoRaTx+QgQzpY/jHqwnXHTix13yN
         +dtlGFk5i75nTUv5pwDg+x5bOb0XE5joJn1BhJrjCyL187ZxdvKTvpBvAXLT0nUh1ta5
         QN4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.4 006/193] xfrm: check id proto in validate_tmpl()
Date: Fri, 23 Feb 2018 19:23:59 +0100
Message-Id: <20180223170327.047820034@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217520098223525?=
X-GMAIL-MSGID: =?utf-8?q?1593217757872181363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 6a53b7593233ab9e4f96873ebacc0f653a55c3e1 upstream.

syzbot reported a kernel warning in xfrm_state_fini(), which
indicates that we have entries left in the list
net->xfrm.state_all whose proto is zero. And
xfrm_id_proto_match() doesn't consider them as a match with
IPSEC_PROTO_ANY in this case.

Proto with value 0 is probably not a valid value, at least
verify_newsa_info() doesn't consider it valid either.

This patch fixes it by checking the proto value in
validate_tmpl() and rejecting invalid ones, like what iproute2
does in xfrm_xfrmproto_getbyname().

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1402,6 +1402,21 @@ static int validate_tmpl(int nr, struct
 		default:
 			return -EINVAL;
 		}
+
+		switch (ut[i].id.proto) {
+		case IPPROTO_AH:
+		case IPPROTO_ESP:
+		case IPPROTO_COMP:
+#if IS_ENABLED(CONFIG_IPV6)
+		case IPPROTO_ROUTING:
+		case IPPROTO_DSTOPTS:
+#endif
+		case IPSEC_PROTO_ANY:
+			break;
+		default:
+			return -EINVAL;
+		}
+
 	}
 
 	return 0;
