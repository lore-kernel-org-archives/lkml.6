Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CF22089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwG9mAje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CF22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeJQBJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED71C2089E;
        Tue, 16 Oct 2018 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710262;
        bh=a4JGKDnKNhQwvhzd+hXv4VOeUoEriHLX4Fh01Mnm7Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwG9mAjeu4FqyQc7FfH5WP6GmIHhlIV3dVTdjFDtPJxd5eZmRM2vH9W45NAXDkcsU
         Da1HF0t0Wo6V+pxk3yi6bX/ZJQOuviN9HMx938iZ8s6GFYHcJiL8awN1hpW++VspQL
         KcxIcKifjIub65q+3+O7sWRYp1UMp75O8aVGYI80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aidan Obley <aobley@pivotal.io>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 020/109] rtnetlink: fix rtnl_fdb_dump() for ndmsg header
Date:   Tue, 16 Oct 2018 19:04:48 +0200
Message-Id: <20181016170526.171451877@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit bd961c9bc66497f0c63f4ba1d02900bb85078366 ]

Currently, rtnl_fdb_dump() assumes the family header is 'struct ifinfomsg',
which is not always true -- 'struct ndmsg' is used by iproute2 ('ip neigh').

The problem is, the function bails out early if nlmsg_parse() fails, which
does occur for iproute2 usage of 'struct ndmsg' because the payload length
is shorter than the family header alone (as 'struct ifinfomsg' is assumed).

This breaks backward compatibility with userspace -- nothing is sent back.

Some examples with iproute2 and netlink library for go [1]:

 1) $ bridge fdb show
    33:33:00:00:00:01 dev ens3 self permanent
    01:00:5e:00:00:01 dev ens3 self permanent
    33:33:ff:15:98:30 dev ens3 self permanent

      This one works, as it uses 'struct ifinfomsg'.

      fdb_show() @ iproute2/bridge/fdb.c
        """
        .n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
        ...
        if (rtnl_dump_request(&rth, RTM_GETNEIGH, [...]
        """

 2) $ ip --family bridge neigh
    RTNETLINK answers: Invalid argument
    Dump terminated

      This one fails, as it uses 'struct ndmsg'.

      do_show_or_flush() @ iproute2/ip/ipneigh.c
        """
        .n.nlmsg_type = RTM_GETNEIGH,
        .n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ndmsg)),
        """

 3) $ ./neighlist
    < no output >

      This one fails, as it uses 'struct ndmsg'-based.

      neighList() @ netlink/neigh_linux.go
        """
        req := h.newNetlinkRequest(unix.RTM_GETNEIGH, [...]
        msg := Ndmsg{
        """

The actual breakage was introduced by commit 0ff50e83b512 ("net: rtnetlink:
bail out from rtnl_fdb_dump() on parse error"), because nlmsg_parse() fails
if the payload length (with the _actual_ family header) is less than the
family header length alone (which is assumed, in parameter 'hdrlen').
This is true in the examples above with struct ndmsg, with size and payload
length shorter than struct ifinfomsg.

However, that commit just intends to fix something under the assumption the
family header is indeed an 'struct ifinfomsg' - by preventing access to the
payload as such (via 'ifm' pointer) if the payload length is not sufficient
to actually contain it.

The assumption was introduced by commit 5e6d24358799 ("bridge: netlink dump
interface at par with brctl"), to support iproute2's 'bridge fdb' command
(not 'ip neigh') which indeed uses 'struct ifinfomsg', thus is not broken.

So, in order to unbreak the 'struct ndmsg' family headers and still allow
'struct ifinfomsg' to continue to work, check for the known message sizes
used with 'struct ndmsg' in iproute2 (with zero or one attribute which is
not used in this function anyway) then do not parse the data as ifinfomsg.

Same examples with this patch applied (or revert/before the original fix):

    $ bridge fdb show
    33:33:00:00:00:01 dev ens3 self permanent
    01:00:5e:00:00:01 dev ens3 self permanent
    33:33:ff:15:98:30 dev ens3 self permanent

    $ ip --family bridge neigh
    dev ens3 lladdr 33:33:00:00:00:01 PERMANENT
    dev ens3 lladdr 01:00:5e:00:00:01 PERMANENT
    dev ens3 lladdr 33:33:ff:15:98:30 PERMANENT

    $ ./neighlist
    netlink.Neigh{LinkIndex:2, Family:7, State:128, Type:0, Flags:2, IP:net.IP(nil), HardwareAddr:net.HardwareAddr{0x33, 0x33, 0x0, 0x0, 0x0, 0x1}, LLIPAddr:net.IP(nil), Vlan:0, VNI:0}
    netlink.Neigh{LinkIndex:2, Family:7, State:128, Type:0, Flags:2, IP:net.IP(nil), HardwareAddr:net.HardwareAddr{0x1, 0x0, 0x5e, 0x0, 0x0, 0x1}, LLIPAddr:net.IP(nil), Vlan:0, VNI:0}
    netlink.Neigh{LinkIndex:2, Family:7, State:128, Type:0, Flags:2, IP:net.IP(nil), HardwareAddr:net.HardwareAddr{0x33, 0x33, 0xff, 0x15, 0x98, 0x30}, LLIPAddr:net.IP(nil), Vlan:0, VNI:0}

Tested on mainline (v4.19-rc6) and net-next (3bd09b05b068).

References:

[1] netlink library for go (test-case)
    https://github.com/vishvananda/netlink

    $ cat ~/go/src/neighlist/main.go
    package main
    import ("fmt"; "syscall"; "github.com/vishvananda/netlink")
    func main() {
        neighs, _ := netlink.NeighList(0, syscall.AF_BRIDGE)
        for _, neigh := range neighs { fmt.Printf("%#v\n", neigh) }
    }

    $ export GOPATH=~/go
    $ go get github.com/vishvananda/netlink
    $ go build neighlist
    $ ~/go/src/neighlist/neighlist

Thanks to David Ahern for suggestions to improve this patch.

Fixes: 0ff50e83b512 ("net: rtnetlink: bail out from rtnl_fdb_dump() on parse error")
Fixes: 5e6d24358799 ("bridge: netlink dump interface at par with brctl")
Reported-by: Aidan Obley <aobley@pivotal.io>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3292,16 +3292,27 @@ static int rtnl_fdb_dump(struct sk_buff
 	int err = 0;
 	int fidx = 0;
 
-	err = nlmsg_parse(cb->nlh, sizeof(struct ifinfomsg), tb,
-			  IFLA_MAX, ifla_policy, NULL);
-	if (err < 0) {
-		return -EINVAL;
-	} else if (err == 0) {
-		if (tb[IFLA_MASTER])
-			br_idx = nla_get_u32(tb[IFLA_MASTER]);
-	}
+	/* A hack to preserve kernel<->userspace interface.
+	 * Before Linux v4.12 this code accepted ndmsg since iproute2 v3.3.0.
+	 * However, ndmsg is shorter than ifinfomsg thus nlmsg_parse() bails.
+	 * So, check for ndmsg with an optional u32 attribute (not used here).
+	 * Fortunately these sizes don't conflict with the size of ifinfomsg
+	 * with an optional attribute.
+	 */
+	if (nlmsg_len(cb->nlh) != sizeof(struct ndmsg) &&
+	    (nlmsg_len(cb->nlh) != sizeof(struct ndmsg) +
+	     nla_attr_size(sizeof(u32)))) {
+		err = nlmsg_parse(cb->nlh, sizeof(struct ifinfomsg), tb,
+				  IFLA_MAX, ifla_policy, NULL);
+		if (err < 0) {
+			return -EINVAL;
+		} else if (err == 0) {
+			if (tb[IFLA_MASTER])
+				br_idx = nla_get_u32(tb[IFLA_MASTER]);
+		}
 
-	brport_idx = ifm->ifi_index;
+		brport_idx = ifm->ifi_index;
+	}
 
 	if (br_idx) {
 		br_dev = __dev_get_by_index(net, br_idx);


