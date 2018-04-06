Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49jYmrlpd88kCq3BaYCcV55VImuklRgtAR0ztAyld7qJoEvbBwBhOaa3t7gi5JFd1ty9n9b
ARC-Seal: i=1; a=rsa-sha256; t=1523021616; cv=none;
        d=google.com; s=arc-20160816;
        b=iI8j61QVs8AVhp0d7gF8z8VrJ03JpVMqRR30TPxuH2YRJfRm1IR116FE1eKjMsHXiH
         AYIiwB0DiJXZrW/rvsBxDc16XqLVVaoRUi7sld2qFLTXu02jngRTUj4rwHvrUt/TOUaT
         q21PyWfxM/MBnGBcqYDt2flK4/TtUdBLXcn51sztsRcOL/WS9G4NvAg6DyA6tbXpwJTT
         xt/6Jc6uq/hVdhnLeFF43LK40UeemJ3DQ1Yxw5KWv9XoJuNy/JsdRRtKlQEoFLbvHlEv
         q+UVGKQwXzRCvocAwYaHBhV8frAnuFWaGzu1+v8Ah6XiPYVi+mv/WJoXulfYP7r7q+wD
         /rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r5j04Q/EBllHx4ys5TaUJ2Dgxzx68q5uQ6lyPnIcFhA=;
        b=sfD+6tbEBevO/62rQ3XKe+VViZmyztbRNI9mebpBZoKt0dCbywYAXE8bce/v5QsdLj
         it1HvKq5bN1/7l5oexcd9FQshgrYmC0Eq/YLX3kdomFj4MbICbtP9NHLII5recURCars
         9ige6svumemAxb8oagModALRO01JnsCR7VdIcJ2xcRl6xGW2Q+SXlgyjDJC0AbbIpNPh
         v8k40mtjZfg3ZNpieSN3LxW/JH5kgvXQFJZ/GjIhpv3xCFY7kIAqklWJUTdgS20+6GRd
         TA4V/byd2FGy7BH4CBAp5gUFLGmyEIOGGobmz3n7fLuqAWnqmfGkMBWglRtEFXkhoAMu
         aIsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 028/102] netfilter: ctnetlink: Make some parameters integer to avoid enum mismatch
Date: Fri,  6 Apr 2018 15:23:09 +0200
Message-Id: <20180406084335.617782490@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003697537524572?=
X-GMAIL-MSGID: =?utf-8?q?1597003914715190861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit a2b7cbdd2559aff06cebc28a7150f81c307a90d3 upstream.

Not all parameters passed to ctnetlink_parse_tuple() and
ctnetlink_exp_dump_tuple() match the enum type in the signatures of these
functions. Since this is intended change the argument type of to be an
unsigned integer value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_netlink.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1008,9 +1008,8 @@ static const struct nla_policy tuple_nla
 
 static int
 ctnetlink_parse_tuple(const struct nlattr * const cda[],
-		      struct nf_conntrack_tuple *tuple,
-		      enum ctattr_type type, u_int8_t l3num,
-		      struct nf_conntrack_zone *zone)
+		      struct nf_conntrack_tuple *tuple, u32 type,
+		      u_int8_t l3num, struct nf_conntrack_zone *zone)
 {
 	struct nlattr *tb[CTA_TUPLE_MAX+1];
 	int err;
@@ -2409,7 +2408,7 @@ static struct nfnl_ct_hook ctnetlink_glu
 
 static int ctnetlink_exp_dump_tuple(struct sk_buff *skb,
 				    const struct nf_conntrack_tuple *tuple,
-				    enum ctattr_expect type)
+				    u32 type)
 {
 	struct nlattr *nest_parms;
 
