Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A128EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239E6208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="dh7D1907"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239E6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFUGbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:31:17 -0400
Received: from mail-ve1eur01on0114.outbound.protection.outlook.com ([104.47.1.114]:58879
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750789AbeFUGbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlJsowzZsmYV30EnNkTiW8+2NIQ/GrE/tQh0IG9855Y=;
 b=dh7D190744m/GhJ1no7h2I5rBuLx+q5hxNp0gcAlmEBR5IX5Z6vdRughrPa6QF2iBLd8bK5xPgPBMcvKtYRKiKTQOLUNivEoOeGdgbnsmj/UpSLFKgSzAo9h/pMtm6fxzRvuaeKbihcMkNfMfnMvfjdB7QWoSRPtbQq1EX7RC1A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from trfedora.emea.nsn-net.net (131.228.32.176) by
 HE1PR07MB3148.eurprd07.prod.outlook.com (2603:10a6:7:31::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.16; Thu, 21 Jun 2018 06:31:11 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     netdev@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     huaibin Wang <huaibin.wang@6wind.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] xfrm: fix missing dst_release() after policy blocking lbcast and multicast
Date:   Thu, 21 Jun 2018 09:30:47 +0300
Message-Id: <20180621063048.13847-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.176]
X-ClientProxiedBy: HE1P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::41)
 To HE1PR07MB3148.eurprd07.prod.outlook.com (2603:10a6:7:31::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ad8a17-11c0-47d6-1f49-08d5d740950f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:(109105607167333)(200054503718035);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:HE1PR07MB3148;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3148;3:zB0ohL2bUQhy9l/4y2ZHDF+gjknmkXaFXy4BdvTfGlLPdvlse6Uzda4K49+DMQVqpLGyz7V9idl1OJX6nAkLcEZKlRS1po24OUi5RHkI/w1T8nZ/lslJDfuULhE9JpiJQlfajEFOBRnHwAQyx0Gpae5QRkO/fXLi7tmM97shI1THllCfWXo0VbIpHKuR6bKNOB0Hm+/A+XM2x893PVk7gFOFpUCoXwtLhwa8KuaSEIFRKk8CaAPc9yzBEiCx7SvLDbq0vlsO/sn+as4ahGE4CYm1f86AWFMMIhenz/ExTH2kYyEolax4WXhOGgRpNaoyi+aqKEGwy/3/7ZZ2biWINw==;25:XyX0tQTVSv1dLiSathIn4cwZkJ1iCfiODcDWubWbZ8NHn0tGrul9wXgW63NAMghPQpIjjJciD8OS+dJtDDBKGu75dPhINU+6Z73Syf7bRRteNrUNH2SHdQc1ZtnNhoajxIJJRs8rR7k9q9KnhvVWDwGguXuLM9breTlAtIwWVGGjYqpdUD3bIg0OKGmfyD/sPERalCCfPplZOwXXKfqtdLNcI5Jg9lni5jZtsbFgUppI4n4lDaaoQoTI33NiTczHmu4ojwdgNdOLVPozD84mRJCPdt/xYdwlqCLCiGxf+Kd85JJSrxQFh3+XMRKdZYW1Px1MTzq7ri2Baue7ynrKcw==;31:NtEPPDKnifWP1sWQZknoi0UFzP4HmsrTOX7Ad0SQPnjgfj6IrXVQC3//2h2yGLH+RHAI2i8Sc73EO49sRmKNF/DTRRlhzob0v4U+wOmZck7GtNbHN4FN2wcuq6hH9xim7INHjxhgVrnJ/tAgfw37b8jR40Nth6Q2hw2r4B1dIU6MXb8M81C9WVmxoItnKLlSPF6sKTOAigKeIdeWrz2ygGTXwz6fGSz+DBYjeK92tMw=
X-MS-TrafficTypeDiagnostic: HE1PR07MB3148:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3148;20:qBr0tw6RFkTd9xRRP1c+r4w91+1+0lJMjKuVVTEJ1gJyZD127zYo8d5IDAI7rzyxP2Pb5e82Bspc6hYyQgN+DdvQ4QqI/Rxb9nFiGmpMfAXIqarV0pjH/JoJ/W9++6gtkv/s6juG+0AAYjq2ZQoPwhRy08eSVLq0QXShqvwaNmjaHnuU1c4sd3Nzcuzh7/irjdidH27JpgdYQhffitLCuTpunRb/KUoLD3hAVUmG00XlL3M9NqLrnmBzJIVb7k31LBtm2s6pNgLhB1Ewu7BWkVuABQug5uRbJV0HMlRwG033t0njgmz16fciYhgalYn2gigc65PdgpQYwvnIvkX6PWxXjc3piIxP0M903FcyWmmkW7Gj1nEHhAc3TAspcrR1WHRo2Lk5XsOb+D39mI58cQBQGFE2nXFNSkjmzp76xC+UXOFn9pAtWvd4IngtmO4AqUJLUITZYS+oLPzHeRrjhZA9IIHDmuUCZKh0DJo9gducFfoTSolWQl7hLnD9eBpg;4:nYAKy5o/AG1jQ58DFeNiOjDB53LyQnnRxqwMCqJM729zAVBi5zGO2NLBTqkdNXAFfuEN4+cEPbRxs+3qVTdxgespCPHi8mfTS4rDO3q9InZK/fBgzwZN+PrJDSJRxgOo700cpDnB3YqcfjeM7GMkEHepy/f8TMUbBtpwMCSi4agnRgkNEdgr+xIqzfoAZc+vFYpl1XSTvPcIAZMu7Rr0T16jbILCF4NBqw0sPO95GjBLIaBiiflwt8FjNHq+7WIh6VZMUUo5IHPcMYhaAVLnmpoMX6xglNTxtiTpAiw6uHT4kMXyayhp03AeAgEiNF22mYfOXFrtrLwl66kCCAU/lq4L+rqU5wJRusJs5jfRmG4G1vJ6RX7iLRCHgziKu/S3
X-Microsoft-Antispam-PRVS: <HE1PR07MB3148B8F5796B52A788AACA12B4760@HE1PR07MB3148.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333)(200054503718035);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR07MB3148;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3148;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(199004)(189003)(7736002)(97736004)(6486002)(305945005)(50226002)(103116003)(8936002)(106356001)(81166006)(8676002)(81156014)(2906002)(50466002)(105586002)(25786009)(47776003)(6512007)(48376002)(4326008)(53936002)(66066001)(6116002)(1076002)(36756003)(3846002)(478600001)(956004)(5660300001)(6916009)(6666003)(316002)(54906003)(52116002)(51416003)(16586007)(2616005)(486006)(476003)(386003)(16526019)(186003)(6506007)(26005)(59450400001)(86362001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB3148;H:trfedora.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR07MB3148;23:VUGA/CxYwXGj1EaN8DslPk5rcfcXL6XZFbgu4MF7T?=
 =?us-ascii?Q?WUWCmRC5MS/TxOqUIJjuwnFy2E5Z1aJ5VKdbDWKnXqYyJeyzO4X2DUGGKJjJ?=
 =?us-ascii?Q?ckMbN9MqZMcUEIuPjRNtfY2YrgqeiqINhy9lytLYbHb569mJ37OFTVT+KUU3?=
 =?us-ascii?Q?s5iG5DrjxLt/VX5brWgMhlyV56pIJ5eqmeTYpkbTOL4RGsU2ycQvD2RhZGqW?=
 =?us-ascii?Q?INDeL/dNCOThmseXNjGrYSTbFYKuNvBFze+O9CAPvaJi6Iu9BLHqMG15E0K4?=
 =?us-ascii?Q?1T9dCfIhpeBHVc/kaNAiB19+Icwhryljg0WMnS0DrXOw5LuYZJUZW3A5odR8?=
 =?us-ascii?Q?bKExBtbj/OoEeKAd0lAhhQUpKf2S+SO8WwglHjFzO8OTz9ERPgZiTWPGXtOL?=
 =?us-ascii?Q?C0q6HVir46Lwl6/azrvQaSDrMhpjoAdbDpaZ8CaZQUXA9c+rB0xBglhnyPcf?=
 =?us-ascii?Q?pNdLXzR8i2KeWvzlCnPCM84Cff1/NdTxfivrlq1SeoDKQUoxD4LzD8IrD4V2?=
 =?us-ascii?Q?gvqD1UJx1wrZNnoO9EhvCcEG1UjzUXYGjvPSLKxBBQUuwI5jpIf+J4hNKPUM?=
 =?us-ascii?Q?RMJaRGjdErXLgeLYZiDOomFOM3ioagJ9v2M0iaXNrym2WR+nE5roh1KrMhs/?=
 =?us-ascii?Q?olY7HSsY/TXzTLB9b2hsHiPTv5dzpl1vhOnCMBaBUICagQwgMxAwWtQT4tbr?=
 =?us-ascii?Q?V8KjBencptTozIyFldkKsAj00tOFWfTm27/NWZXbhseYn7wVormKDYmKubP5?=
 =?us-ascii?Q?xppzrCPtsV/UO/hOw49at0UkZ9HhufDse4UmjG3Q35woZ4R/udo4mif9YrMu?=
 =?us-ascii?Q?TA3QBwFb5jesZccq60nB+NhCC75tuJ/0w50/evvO6IabQYDJdVmU6aLgencH?=
 =?us-ascii?Q?4iHQ2dE3p1Q8SkweqoSevfFdBIC0UxaRvSyGPuAlS+YVGk79jFtQc3TbePCi?=
 =?us-ascii?Q?uHpl9YmX5yA78fzNoH5uJIEhghYoCy0QaLO3sDM0BzUS4bSIMB5J6M54QHzG?=
 =?us-ascii?Q?5ybK9Ln6n/tbwcgOdKXup1j9rs04nhWvwEA+bYszqGoDkO4JAmql0XVnJYfI?=
 =?us-ascii?Q?czXMhbgP7pe2Qurb40Bdazkj6Nqz9xGYzqrnPZcTylHrGAcMTdVZqCjEb7kx?=
 =?us-ascii?Q?1r+ZzG9LQf3ZmzGgpZkpzUCj6itNfBXeMjZ7QfLXrCBZ5qJn3VUDfOM8OKbW?=
 =?us-ascii?Q?EGvwkOWyk2osfEZ+jQjKD+V89B03Dj0iYZg?=
X-Microsoft-Antispam-Message-Info: qw56HKmcgGT1JPJEXvjk7UsTVVXgfn5jPLIArHRfda6Mja91gNg2oSDA+R4wfTnc9LzbIXJmeXvL3boOkOIsdhkGYKB3IiE1S5NOaJcMObcxtWopaoFA2AjyWkDTngYUCfp5ZmImPQLqvH0c4qqwUo3fJHbUEQVKUtQcx14ORxMLDCvn9hAQXKbgg7zJnzjm/hoi08suXPp43wjDIukY79p65FctJgHK4342Yb/wEKjE7f1tqd0OJO680UAxPoY41WyezMV2l3gG1KGxMnfEJ4cFxrvzG15BTcqPBhjehezWnjjE53UN1d9ZsKzoLoZIX8WqxotwDxX02e7r29F728lX6azVMwMET5wvuwm/ne2l7/MzjPPqkUH3VimOjbgj
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3148;6:e3ULh99otZKTH25e12ESqGnkOZH7Arg2XEKTdGduADViy2FevEW/FuRlD9SQUFmkC5/WgdlkPtLcWX/sYzESG2HUO7nzmn5g03b7NcNsb0KtcFKq4CMpxajcP4sDnXU0lHH40rpZAyVSP2Xl6etCcnlE0ufOM0mpaoqjS5Fib6f6+1rLpIFxwQkmt6bBsnHgXOhh37DJmVYURLunGPPZlLeNgfnmf00vZdZETTNebQ9qqqp0jiwEVvCVmF7aNQ63MqEnccqGmlQeDyzzqiqyz8fItRZajAuMHgjGRWIBjEfTL1vR+7ajLPR5gHR7XweNYYjlzFd2d3gisZK7xsprvdhV9MyAw2d59GSF2+Uck/KcZeoUv1rTov90UclRqlC0rQXY9/uxkjFVBfwhKYGlLTr0kwUJHvEjtsJHANNYO6OvAFS5AJtZsabvmNf8+7xfNt85GEl9nkEdAIMUZFMGvg==;5:r9WOTcG2FcZbmbI99jBXMfC7iOJTfmGbxt3fNWkNQTrFv+yEe9h4SeDmyOKP7N+9zPlkxlKDhlc/Uv6K52M5KdQTMlrxmHqVteH2VI/Xhx0xpp9hfB2Lu9DnvOJYTgZw46Znr4RXc/+znhohYt7JtVk2aUE1qXxYGpt/74Q7aPA=;24:zPUke+onPgXLZIHLFNdN7cCNeZllSgtXttI22+VecsXSFBj3yxmS/1MpZKgqOfvA8QVzus/kDAM/ePuD7IVI2FHR+8bl/J5XBaylwG4DXXo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3148;7:U5cTVJDP2q1A/kM8EuIzSyumVktl/MdHogZUl4igglQm/vWKmpBP77kiFsSyErN4WMyElzCTN6BS93mtLjIRjip3mv59s66D3K3yAr4TEctimeAxIW6jDYptDSzd6QRDy5kb5hwFJ2AcOlNJ79L+ne5RfDEi1zTYVrWG2yQpmcn4Nf2NrV5JYxYHe0iVfMEFBiNZ3bQNpYFJVescqA3L75l32afgkN4gJfLbbol8VKTuxlUVy/L2Dzwd3HA6SU0v
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 06:31:11.5554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ad8a17-11c0-47d6-1f49-08d5d740950f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing dst_release() when local broadcast or multicast traffic is
xfrm policy blocked.

For IPv4 this results to dst leak: ip_route_output_flow() allocates
dst_entry via __ip_route_output_key() and passes it to
xfrm_lookup_route(). xfrm_lookup returns ERR_PTR(-EPERM) that is
propagated. The dst that was allocated is never released.

IPv4 local broadcast testcase:
 ping -b 192.168.1.255 &
 sleep 1
 ip xfrm policy add src 0.0.0.0/0 dst 192.168.1.255/32 dir out action block

IPv4 multicast testcase:
 ping 224.0.0.1 &
 sleep 1
 ip xfrm policy add src 0.0.0.0/0 dst 224.0.0.1/32 dir out action block

For IPv6 the missing dst_release() causes trouble e.g. when used in netns:
 ip netns add TEST
 ip netns exec TEST ip link set lo up
 ip link add dummy0 type dummy
 ip link set dev dummy0 netns TEST
 ip netns exec TEST ip addr add fd00::1111 dev dummy0
 ip netns exec TEST ip link set dummy0 up
 ip netns exec TEST ping -6 -c 5 ff02::1%dummy0 &
 sleep 1
 ip netns exec TEST ip xfrm policy add src ::/0 dst ff02::1 dir out action block
 wait
 ip netns del TEST

After netns deletion we see:
[  258.239097] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  268.279061] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  278.367018] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  288.375259] unregister_netdevice: waiting for lo to become free. Usage count = 2

Fixes: ac37e2515c1a ("xfrm: release dst_orig in case of error in xfrm_lookup()")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 net/xfrm/xfrm_policy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5f48251c1319..7c5e8978aeaa 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2286,6 +2286,9 @@ struct dst_entry *xfrm_lookup_route(struct net *net, struct dst_entry *dst_orig,
 	if (IS_ERR(dst) && PTR_ERR(dst) == -EREMOTE)
 		return make_blackhole(net, dst_orig->ops->family, dst_orig);
 
+	if (IS_ERR(dst))
+		dst_release(dst_orig);
+
 	return dst;
 }
 EXPORT_SYMBOL(xfrm_lookup_route);
-- 
2.16.2

