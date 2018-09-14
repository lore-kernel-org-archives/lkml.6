Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D263ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147221476
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OEuXT9Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B147221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeINSTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:19:36 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:60592
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeINSTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HajUu/WgPzQ8CJMDC4scAtOrLQhbGs5JiPspH+eAkNU=;
 b=OEuXT9OoIeW4HojD95Uk2DrS8qWzCs2zEgCcycC6RPKJcwGHuEgrI34nYeL3iubl3cHSlVwRYyb9NrRy/2tqnZNVVxDOj84VaKFIqZDDzpy13RApXmG7Y7oxEIlW8GJpWRZXDrrKbYRgH0vrrM3nn+gnPNbJI4KfTdhlQc/EFss=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3261.eurprd08.prod.outlook.com (2603:10a6:803:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 13:05:03 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 3/3] vfree, kvfree: Add debug might sleeps.
Date:   Fri, 14 Sep 2018 16:05:12 +0300
Message-Id: <20180914130512.10394-3-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180914130512.10394-1-aryabinin@virtuozzo.com>
References: <20180914130512.10394-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7557ff-de00-47c1-38f0-08d61a42afcd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:OxsGGzySfv4xeXO0Z/4eP002NFWzVBJr0wRyterpRMmPg9zzYW/13g3cK2He93tPcMZy2JERoXcjdJyYBe4hkT8SrsOPFAP/n0mb90tkpOTyWuU4zGfOfrgn9PRBuyaYCfUXfcXUGDhpTQX4kVu+HL6kSYC52JgpemGarmGd0oZSuZcKtcLBcknYu4xfEXZ9Hj+7vICB5DhviIohTsVzux30A7ya070CgnFybxFp2nhrScetYHLCHfJZUked3Re+;25:iKlx8BvkMBtwkdOy5a1Q+SXa48r3t8H4Un8eDNw5s/8R4LGPOHuU1iyRGwtYhsb9y2o0pJAgenVIjhPlYaCjFtrXubk2Gs01oWmzCi1+CZ7QCvzMELt/IcbQX6J3tDw2xsxKkdolc0ghpdegGttQmJvRXpCnsMdaD4zvKFPDKxPh9QnydVo5s5aE3kWtUDrkw2QHDx40LCo8ej2cJj2nMVOAVp+1gwNKdgrT5Rv6xAM8HbLDRk5OhXg9AWUmDIkSo6VOECau9T1zAoNXz8nfE2KmwiK43QMVz+AkMlQgrlsLB2Z9+vJulFCYFgIW8LXXVcpzoJdvHCRqZwz3tIY2jw==;31:0mTrL/+gVidIOm33HpQeM9QrstyAh5QrtcOqh4gTTLmaOAeLiuKclF3uiIFwicNLu7ZsaWTjht7GmskLtfNAhgYLja6kg/tK821rG0eNSJUZZsU9Q7vQUXbB6YbsoB+maFhhtlLgE9FuN1PIs702ntbcH1AfXB4XCxXNWvfKNqAZ4COpPT/oQsi/vL3NfkPNA/XysBsYq8moIyqGpQdfVDnt2I/LEaxQ6Vml322bUhg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:qe4Cg/z7DdTHQj811/0EgBwK21/yh0SsOCwlZ4hXhtoQ1Yo2m5y9G6M2SWngv0V5M0KEKiJkKqXsie8B1pI37o6yaZHcxUja7Qp08o8+Cjf3J/p7b/9HykDxONWkszowQOkj0yTEOs62qWBLn6UZmLNqouvnTy32/umx5wqnlxUpCCv99NC1fyBKM+Lc6B4fceeS6krQTQV9u9FpqONf90mLxC9r2IQgEbG1jL2tnJffcr0ucivzBHbC5H/r6pOpKKQ9SJptlFVuAVf2hudMD2/Z7fq+Q9pUmFDbGVElfBouRnh2mcf7SVnrqy/6+1fDTE7ZKbEE2uFQYx9pY0FTfYkztXT1lN7FvcYMEcx39vKzSQoTeyvfViQKgVkVVVSU6lvV3rSR5lFLfxefChNq8NA15UH41t1xVBOBY6tkxixm4x8VKgbHVcGtl9CAWqtx7XG/aSRXTHCXee53NWe+hvm6mO9XdsFR1rixfWlhHxnWwCsdrqX3zeAhGLwEuj2K;4:YnMqJjUuPkbNKVe5YrQ5gC6cA6KO74TMYzDQ/7+b9p7kW4whtMQ+bHyxMlSb2RFSSNJSsVUEE2wOP+Ro+sjuxHa7sK0F7rdU7MdCUtYHvKtFomni6PbKN3rn+OtSU+Cucpw0357NqE0Pb2lY+aiY2Rxpu9iXDiKqrs1kWA0SsC2BeCQNW5kbQ5D9N+gM+xMLdIWRFDn/9vHu4oYAH+1txdLG2wst4diPU2Ld5LfJMAQB/pyWNQrds5As4yk/bINQamMBs2wUDa/T421NEuhzfA==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3261FD662A7A9C7218BE5773B0190@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(199004)(189003)(107886003)(52116002)(51416003)(66066001)(76176011)(478600001)(81156014)(7736002)(305945005)(25786009)(105586002)(50466002)(5660300001)(106356001)(53416004)(6666003)(81166006)(6916009)(2906002)(53936002)(6486002)(8936002)(50226002)(386003)(956004)(1076002)(3846002)(6116002)(446003)(16526019)(4326008)(2616005)(476003)(11346002)(36756003)(48376002)(16586007)(6512007)(6506007)(186003)(486006)(97736004)(86362001)(68736007)(8676002)(316002)(47776003)(54906003)(26005)(31853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3261;23:Pshxg/9eecm5eBJziJY1oAea2gLSWvFq9v8XbI7uw?=
 =?us-ascii?Q?50xgA5AtzE5XsP/CBHI4uzEQWcmkH9Fjo0mf0ztVOE1060eTpxkdWOt5ZTeV?=
 =?us-ascii?Q?hs5+9Y/IhM6ARxuQ+Zd+4lbuVLOwyh5S1s2tDa6pcS3LdOXi+cpw8OJr+o3j?=
 =?us-ascii?Q?6a+yY6YSXPbiQY48LLKAGN+ZFfRUMDAaD3N3Wp7R3jLnUFqapelfK6KGj38i?=
 =?us-ascii?Q?lYrKE5nbAPttT0JSgd5IAKyJo/oVoENpSLyWaf7A2WgbblptPgvgylRE2LBB?=
 =?us-ascii?Q?GM2Q0Y3dm4Tb1chmjHsIHNB29x3gQBi4M+XMh9NcCkADkQlkjgZPMUkZ1Sd6?=
 =?us-ascii?Q?0KxouQt650Ypxu4Lku7r7lG9ok2nyAjH5+PY9pMS3n2q477WFWM+pljNLhYO?=
 =?us-ascii?Q?ZZXnY/46+Zv2smC4eIx/eEjR4mO1QmuvV6uOtDlCkLINDochUcvIcMSs5vLQ?=
 =?us-ascii?Q?LDCjlafbM68HEMkQMOLhrJnf9OMQvdeo/juUvm5CF4pU/7kiMB3YXgd/S9e2?=
 =?us-ascii?Q?/EW5s42YFH5hSwvK9gzcQ0qFaVlGpTwfeWmbOFb9xxJquKT3cwJGzA1JaNg7?=
 =?us-ascii?Q?fj4g2l2CEsp/JFF8wEvlDOmGmcFzWEYfUF2x9bB3V5AlP6oMBXr5Wh+rx4IW?=
 =?us-ascii?Q?0EupsCDGObPQF8suTotOUBpSxCJWfDLfOEH+ybf/E4Q1phrHYqB38yzVGS+w?=
 =?us-ascii?Q?JbLgn+v7ygGYgVcRI1i/sUYReAg5p0Ra9qc9p+vP51CnXQZDYv8YqwkDvuoP?=
 =?us-ascii?Q?JxI0cB0z2DSAruhXJdeMcY85LPTFb2DV0/bFAjRYnEs74IqJV4knsbdv+UYD?=
 =?us-ascii?Q?A4IamBFT88/adgtcxqzn6Sk/niubI3e1pDIYcaz3/+a5NkO6vLqdJZuXNCjS?=
 =?us-ascii?Q?vc4UspNwyG3DhJ6fY45KhwN5X1pc7X6j6HxyTX1NRnZDWCm9Cmf6SQ0HAggq?=
 =?us-ascii?Q?YWo+hnZB9wEaZQXIQ8p0NWj0S17TiVT3YMhjESt4eMiCiD2H8YIUHJuF/7N0?=
 =?us-ascii?Q?mLI4wfgV82DLCCvB18T3ff6+2+fT9hK5EuzOlHlTmhvsxRTpVXh0weyUnFIM?=
 =?us-ascii?Q?axKeecP5HajHmNyhwq2jdugdPY9LgKLzrqkxvjBg+dxeCacquLcVevyRuuks?=
 =?us-ascii?Q?Uqa23owABoJLAaeAcytM/UViUT6HrSP7hrwSYgCunnbXdUmxuGfCcSACR3y+?=
 =?us-ascii?Q?huzD9jDJEo8nmRXKb80AkaRwEsLPOa6zypbWQRXDStO8IpKAa5nVfX57Olsr?=
 =?us-ascii?Q?jf1qAA6AJemxUHwsO7FWjbXuXUeE74ccl6KjxmE?=
X-Microsoft-Antispam-Message-Info: ceuj8Pvn5USXj2tZ0JK/fS2tReuxrGP7STsHAHm9Ta1LwGECI/bsfYo6bmvpucQ6zuB4a7H05MNji1yvToYGOI43ekBU7o8JwzeCrscj+BzTKjGRtsxjd3n2i/aaFzUaLkSnyzT8w0bIx2MbL9RYGv3i6w6pTVLTvI1H8V88l2BG8JmpCjtenwSREF38iIUTpJBgxccxOikHmkpWxehp3QosA7o+hJyT1CbNLcx/tlNq6b3mQWZWit6NrVaDgxXSxnCAMHTsIt+q9o+c4ljb22vT9XMQSKO+aB6Z6XCUa245GDpQGJbCCHrZmaqpAfKAeJhhNC/1kvoc40XgaViOZVL+6bhVOYVguvw/AH+zTDM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:JPMvW5ZNxP/KIdQ7LeuKzZ7i1NAY5vmPkOvTzSgFbCsHuNwOB622ktX6+lerOERVS0cTdWc8NGbJkgjqYM5T3ffTdrBjbjrLSqYVD7gLS1Zx1z1Xu5uQdstWYctIkb0bInnbjt2I4mCVLiG/DFWHDcSpHGZNMdt7fU/0bhB5ytdVymbfXpcM/kXjW1FuhtaFFaFDmypk6sK8EHuzgHk8Q3HLFCpXeEdpVNKcJVD65TmPhechiYWUMhn70SpvJ5OtgIp2eAZUQShRASWWecLBVpYSdGFduFtiwB5SJPFsK4R6E1ydtmfvhdLGbRsWWXPuVeCxZiOiS67p/mUIxHsMgN8IEDJ+sHKsdexSiylTz1HLIVN+FA/oZgxngHGrA4+kbQ5TDCA1rWaSf+F3YYstqUBgG8EbgQcGLeWCSJoe7Uxf9aT11yxdmBUKgfPwXTYVpPARIJAhPThoT4KhlcbwMg==;5:mke2Hh2lseCS6M9qjUjcv3+bqtB84aL/2BMi0qThFiy4IlfIVhLFaov+0uLxJhu56ENQX5K0PqNq3HZ7hjKwL/B/f/qrsCz4JjcQ2jT9ljLs3SkXYzy1zymgQ4AG0ZzJBMVwuGoRVbOm66+/tEh+KHLXvx6McXe1NCT2UdEs27g=;7:FZrfjyr7bouRWjYYu43/CA3sMOQ4459GUzLBFxFUr9N7hqw13krNObiGtRtC5L9pBNagSgM1jiaw+oUuRu/+xSOmO2qMYOjMvtDukExfV2kHBUsQOfioFz/fsu8AbiGF2eUL5NaDHQFVIJ8+lbF3ZXHZ5UvHFfjRtnHXslZexbTPVqI2W/31dM9CtIaIvshysZPAAvN5bBoj26uW1vcH8MngePpfisFmUGgaAGjHk6+vPRpw1r5na11P2aLNiegP
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:Q4Fsnuvgfziw1Hgz8kMh5rXFuH+TjVqo4P8LWtrIotwbipczW2wPXfY275RxgQXYAUn+vAAhbStzf2T9pzyZkTt4/MIEDKj03/21X8Y0wWoVoR9TBzlbAT0xZQdnZtX72uSHhtPKpksf+7tC5Lw1sAvWpMfvlWJVFiW6osuVsFg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 13:05:03.5067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7557ff-de00-47c1-38f0-08d61a42afcd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add might_sleep() calls to vfree(), kvfree() to catch potential
sleep-in-atomic bugs earlier.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/util.c    | 2 ++
 mm/vmalloc.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index 7f1f165f46af..929ed1795bc1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -446,6 +446,8 @@ EXPORT_SYMBOL(kvmalloc_node);
  */
 void kvfree(const void *addr)
 {
+	might_sleep_if(!in_interrupt());
+
 	if (is_vmalloc_addr(addr))
 		vfree(addr);
 	else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d00d42d6bf79..97d4b25d0373 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1587,6 +1587,8 @@ void vfree(const void *addr)
 
 	kmemleak_free(addr);
 
+	might_sleep_if(!in_interrupt());
+
 	if (!addr)
 		return;
 	if (unlikely(in_interrupt()))
-- 
2.16.4

