Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLeQh1+9P+6WFWFaJAzytcO+3YhkJ6YcmX+5F05dtFpn8PJ1sKWQA5BsaDfVaJuv1MfXF0
ARC-Seal: i=1; a=rsa-sha256; t=1526631688; cv=none;
        d=google.com; s=arc-20160816;
        b=eqQBGkUyOVAIaTYTMtLNe2eIuCOxnOQ4Hc4BVJ2IoyvaZlrAD/cLyYR41biTb7j2rd
         YbPSAZuWos3hkZ0VlPh7Tjd9bnYPTPaxo3XsPqRUIBUZW+JAhSoWOe0+K8RblfDAnN2N
         yD8lnw/78Keqn4LZqo2/PrmEX+M43S+NoctJE3nIb2GnC5+K8xp/FUJK7y58cHmelJe8
         WxQ8fCDPwYyOl+lGZUqgbSEV9Zz1gUpdjH7U6O42nBVjHjnHyekGTharxeSu6AkePGS7
         09SfEWZj1UJNgj9by7WEaaIDwfEj2TCy5QX+qiOTWsIoIyOprj+hlDGAFjsfIIlI9SHm
         8vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CI2ts6MvHRPABVWAyErR6x/c/DfNzQHDOOBDj5HweEU=;
        b=vwKJ0UkV6iCzgB+R/KlsKkMZFDBAbN+Q2DdhZWRQ0TASB64Kr50UltHAsoRRrYvfxR
         GxfZhbtAiNk0xEnWWca7ANIaiOFIursdzwsf75a/Uf0rgfYRK23QKLkAiLHxh+5twb+Q
         8UBbYuNvxoflDjMi7LO+3al5dvxD3P/z+2JphtWgiFxfxEmd8iJ14IIiirVmSs7rA+En
         UApilv7gBoAjna2D33SN5rI/uA/nvfhg+YtvGDhf6Uw6Z0Lz3SYgkxSxGcIsDMMg9W7v
         r3no9bshD6KTQlQeoeTjnVMctt4U7S9TpD/HO+St93YErsPfYF9Li4enie9IkgM4OOBb
         18dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SbBie/if;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SbBie/if;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 12/33] openvswitch: Dont swap table in nlattr_set() after OVS_ATTR_NESTED is found
Date: Fri, 18 May 2018 10:15:51 +0200
Message-Id: <20180518081535.574311488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789181042788147?=
X-GMAIL-MSGID: =?utf-8?q?1600789349566103903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 72f17baf2352ded6a1d3f4bb2d15da8c678cd2cb ]

If an OVS_ATTR_NESTED attribute type is found while walking
through netlink attributes, we call nlattr_set() recursively
passing the length table for the following nested attributes, if
different from the current one.

However, once we're done with those sub-nested attributes, we
should continue walking through attributes using the current
table, instead of using the one related to the sub-nested
attributes.

For example, given this sequence:

1  OVS_KEY_ATTR_PRIORITY
2  OVS_KEY_ATTR_TUNNEL
3	OVS_TUNNEL_KEY_ATTR_ID
4	OVS_TUNNEL_KEY_ATTR_IPV4_SRC
5	OVS_TUNNEL_KEY_ATTR_IPV4_DST
6	OVS_TUNNEL_KEY_ATTR_TTL
7	OVS_TUNNEL_KEY_ATTR_TP_SRC
8	OVS_TUNNEL_KEY_ATTR_TP_DST
9  OVS_KEY_ATTR_IN_PORT
10 OVS_KEY_ATTR_SKB_MARK
11 OVS_KEY_ATTR_MPLS

we switch to the 'ovs_tunnel_key_lens' table on attribute #3,
and we don't switch back to 'ovs_key_lens' while setting
attributes #9 to #11 in the sequence. As OVS_KEY_ATTR_MPLS
evaluates to 21, and the array size of 'ovs_tunnel_key_lens' is
15, we also get this kind of KASan splat while accessing the
wrong table:

[ 7654.586496] ==================================================================
[ 7654.594573] BUG: KASAN: global-out-of-bounds in nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.603214] Read of size 4 at addr ffffffffc169ecf0 by task handler29/87430
[ 7654.610983]
[ 7654.612644] CPU: 21 PID: 87430 Comm: handler29 Kdump: loaded Not tainted 3.10.0-866.el7.test.x86_64 #1
[ 7654.623030] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7 06/16/2016
[ 7654.631379] Call Trace:
[ 7654.634108]  [<ffffffffb65a7c50>] dump_stack+0x19/0x1b
[ 7654.639843]  [<ffffffffb53ff373>] print_address_description+0x33/0x290
[ 7654.647129]  [<ffffffffc169b37b>] ? nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.654607]  [<ffffffffb53ff812>] kasan_report.part.3+0x242/0x330
[ 7654.661406]  [<ffffffffb53ff9b4>] __asan_report_load4_noabort+0x34/0x40
[ 7654.668789]  [<ffffffffc169b37b>] nlattr_set+0x164/0xde9 [openvswitch]
[ 7654.676076]  [<ffffffffc167ef68>] ovs_nla_get_match+0x10c8/0x1900 [openvswitch]
[ 7654.684234]  [<ffffffffb61e9cc8>] ? genl_rcv+0x28/0x40
[ 7654.689968]  [<ffffffffb61e7733>] ? netlink_unicast+0x3f3/0x590
[ 7654.696574]  [<ffffffffc167dea0>] ? ovs_nla_put_tunnel_info+0xb0/0xb0 [openvswitch]
[ 7654.705122]  [<ffffffffb4f41b50>] ? unwind_get_return_address+0xb0/0xb0
[ 7654.712503]  [<ffffffffb65d9355>] ? system_call_fastpath+0x1c/0x21
[ 7654.719401]  [<ffffffffb4f41d79>] ? update_stack_state+0x229/0x370
[ 7654.726298]  [<ffffffffb4f41d79>] ? update_stack_state+0x229/0x370
[ 7654.733195]  [<ffffffffb53fe4b5>] ? kasan_unpoison_shadow+0x35/0x50
[ 7654.740187]  [<ffffffffb53fe62a>] ? kasan_kmalloc+0xaa/0xe0
[ 7654.746406]  [<ffffffffb53fec32>] ? kasan_slab_alloc+0x12/0x20
[ 7654.752914]  [<ffffffffb53fe711>] ? memset+0x31/0x40
[ 7654.758456]  [<ffffffffc165bf92>] ovs_flow_cmd_new+0x2b2/0xf00 [openvswitch]

[snip]

[ 7655.132484] The buggy address belongs to the variable:
[ 7655.138226]  ovs_tunnel_key_lens+0xf0/0xffffffffffffd400 [openvswitch]
[ 7655.145507]
[ 7655.147166] Memory state around the buggy address:
[ 7655.152514]  ffffffffc169eb80: 00 00 00 00 00 00 00 00 00 00 fa fa fa fa fa fa
[ 7655.160585]  ffffffffc169ec00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 7655.168644] >ffffffffc169ec80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fa fa
[ 7655.176701]                                                              ^
[ 7655.184372]  ffffffffc169ed00: fa fa fa fa 00 00 00 00 fa fa fa fa 00 00 00 05
[ 7655.192431]  ffffffffc169ed80: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
[ 7655.200490] ==================================================================

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Fixes: 982b52700482 ("openvswitch: Fix mask generation for nested attributes.")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/flow_netlink.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -1296,13 +1296,10 @@ static void nlattr_set(struct nlattr *at
 
 	/* The nlattr stream should already have been validated */
 	nla_for_each_nested(nla, attr, rem) {
-		if (tbl[nla_type(nla)].len == OVS_ATTR_NESTED) {
-			if (tbl[nla_type(nla)].next)
-				tbl = tbl[nla_type(nla)].next;
-			nlattr_set(nla, val, tbl);
-		} else {
+		if (tbl[nla_type(nla)].len == OVS_ATTR_NESTED)
+			nlattr_set(nla, val, tbl[nla_type(nla)].next ? : tbl);
+		else
 			memset(nla_data(nla), val, nla_len(nla));
-		}
 
 		if (nla_type(nla) == OVS_KEY_ATTR_CT_STATE)
 			*(u32 *)nla_data(nla) &= CT_SUPPORTED_MASK;
