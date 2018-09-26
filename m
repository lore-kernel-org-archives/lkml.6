Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF043C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F77B21528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GMVFUh84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F77B21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeIZV5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:57:39 -0400
Received: from mail-eopbgr00138.outbound.protection.outlook.com ([40.107.0.138]:15334
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727502AbeIZV5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itlu2sM+kK09nTS1pZNRW5IhgmrokHEIQH3nT0W6i/E=;
 b=GMVFUh84d+cHBNPN7ddPsG2OaCJaEfM2INTzQMA99SBXaxHReQJN3pZ86CKZzi2x2Zdtko/VnjAaEOZQvxQ7lot+imVYy/88McCpeEFbUQ/BQkGIxYep+3wkSuaZWIUiIUd9pt94h+abTlRkPjBIGQd4efQXQgHPjxOPOBKFXlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from localhost (185.231.240.5) by
 AM4PR08MB2772.eurprd08.prod.outlook.com (2603:10a6:205:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 26 Sep 2018 15:43:46 +0000
Date:   Wed, 26 Sep 2018 18:43:42 +0300
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 0/4] IB: decrease large contigous allocation
Message-ID: <20180926184342.44deaa4f@virtuozzo.com>
In-Reply-To: <20180918212351.GB3661@mtr-leonro.mtl.com>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
        <20180918144623.GI11367@ziepe.ca>
        <20180918212351.GB3661@mtr-leonro.mtl.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM6PR0502CA0053.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::30) To AM4PR08MB2772.eurprd08.prod.outlook.com
 (2603:10a6:205:d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e597a5-06db-43b7-ffe3-08d623c6d8e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2772;3:DG7b7ghDQaLjJdV4TAakPComlkcHnobFwdF+tWjbKJm8Ahu9zjzW63RXK5Utfl0IKxEG6bGJSn+/Ulcn7CLo6ZRvAq5igfy7z1nP2EJ/j6ywJD0ZMqFWJ6/uPXogC0jQ39QaYLl6xIX1st06vo4Obr0i30UNcbkqHtqypHW1182CAP5XOaskyyJkEsTgCVofiph7KN1+s+3ffmfvbQj9il/V1pPzc3rjoZyxD/ub4qG1iLYyltJ79K0zk1KHfNDh;25:tvHji71drt1EIEO/IBy7a4uTy7VoK8+yLtS4szhCR4NDnSuOdipn9bXJEqtVHmlE0wqlI1ofmpYpMbjZYgdAmnqXJtsQqpBH4oxjDsUoLGNsWpWv21Bp/8ofAYpNNtx95r0/hsqo2CSJ7+t5mX4Z4dxFgZLdBWOexweWtAxCxL5+k3un66LfrqJFXfPnJKN8rE62eJ7sul0PT9aNicfxVPMIBe2TNNYs+kX9E8c0NJrT6asT08Bek+r0DxnM/Yk8u/14xjl/+8jZt3l+DwV7ozeA3p1nUfQgPQDGdwc42mvug5apxAVuzddsYO11wNdDFY/uo7Cw1E6fGBhwsLMHAg==;31:FEizinco3lZm3OpSByXloAvXnjg9PANkRfNBaTh7YZ8hme9QN2ymGUeW/CL49LuVg+vY1s9617sAwkUNU+hbwC6L/5Z1s7wk1fYRZIOygF5vGt3+cq1iVb6TaWwZZeUTHIcWjSc40JL4Zka9de8Z1aqS4PTHdP3d+yxIRzS95cx+JHckH7ISNu2JdbIgR56dFigVKFHioz69sSr1HBsLIaUeZAmmczeSmT6WDg6iwO4=
X-MS-TrafficTypeDiagnostic: AM4PR08MB2772:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2772;20:2gsYSMDGu/3fRnoXeZL5XDNR8URPdOyg1zl+RVlpP09x+8HUVAHC8VQomaADPKKmiH7jnct5vuT3RYTnKn1UaqopqTXBiTAheycx5XgcQRxkyxPIiZZT1pzKqP0ITX2dy2w5msGsyjAyny9LJ22bQi2TwnNlVaBsVT2nDN9/A+Fi0w+/bfP2zaOX3jDaJKpXgbnvMkc5agLoptaBRUEQsVDl77B907jsNxWkei657BfmzVW6f1FVMkUj29FSseSzFsy6Xe56Gix3cl1r1KBmuh+lf5uEOQ3fI01X010jE9jQGf4fx7SyeK/zfNvzEz/s0d2QQM50OIiE+6y0XzilwC7DesHFjwgDRmxaKupJjxEnaypUrENZkIKqQcbsOvroFdbM0TvpWHgRuCfU0AdivNvvYy8WV1V0AhoLY57oQf3F6jO3eLWcztiH3nbvdfpEvr3ZoyxJxQAV3qsevA1V7MKlvF6pfIRHGdeK0z110ju752xcspBhO3xDay76Bid6;4:LneUHg3LEd+X6YVwOKzhrS3z+bnySZ1Dc3haNyR4gpDl2GfJqujnUCyIvZOJE3wcB3mop2dT1r4g8VomoWee2cA1QuBHK8ZXxQMNzvlw1BEaszsHRv+A2bX1XAtVbK8vrhf6nwtuBlEUvz2DGMDYteKP24gc0WtJsTT1gX/QWAoxPmmRrWbYaqdtn/yMi7AmUj/f8Z0ZeZcbDCkOE1aDDBAhi8FNTwGsu5D7WNlcSJXQGVlq/c63Ma0HVi3qMLHVeFjGozQ/F3eZCWlispRyEA==
X-Microsoft-Antispam-PRVS: <AM4PR08MB2772923DAFFFE087AF557B008A150@AM4PR08MB2772.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR08MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2772;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(396003)(39850400004)(346002)(366004)(136003)(199004)(189003)(4326008)(2616005)(16526019)(26005)(956004)(81156014)(186003)(97736004)(81166006)(54906003)(76176011)(476003)(50466002)(50226002)(8936002)(478600001)(446003)(8676002)(36756003)(25786009)(47776003)(486006)(2906002)(44832011)(11346002)(6496006)(106356001)(6486002)(5660300001)(7736002)(23726003)(1076002)(305945005)(66066001)(14444005)(6666003)(230700001)(7416002)(6916009)(39060400002)(316002)(6246003)(86362001)(76506005)(6116002)(229853002)(53936002)(105586002)(68736007)(107886003)(3846002)(386003)(52116002)(39210200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB2772;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR08MB2772;23:7UuJmw4fkWNxFv1BOB9+V6cst2bFrnw0HCU3i6FfV?=
 =?us-ascii?Q?VLBR7ph7Q84BPD8nvQMFKV8ZlmgEg7Myj+mlzHuIy1Aj/2Ym9mNkFWmHB5X3?=
 =?us-ascii?Q?4lXIS4+fchLvySP/vOTgMxvTdDpRblkcahWDQDaIkQFyiUfxb25YW4P5LD9p?=
 =?us-ascii?Q?MC1NixlI1gCDJwyXe1jK2x9ukSCShH2XI0zB9Hber4LyYZEdQlyPINsexI5G?=
 =?us-ascii?Q?d8f+CysmYv+VHMVbBVw8QtdHVYHZhRt24x5NvpvFfMF7irY9Q2Tydgc+9HK6?=
 =?us-ascii?Q?1rsbON9FJxb6LsB/my/Nhqv164jBrdKepNogHc2PxjJnLZ0C5xzaVbbtdCF9?=
 =?us-ascii?Q?gy1RJG0Of2uJ+fqGtSmPoB6HvTzOSNjF9A+86cLUMl5PGKq67QL9kvfq9m+f?=
 =?us-ascii?Q?vyudLmLRoDAxR5ErqZqgg8EwaSzsHxxYF+pe8skNMERCUoQObIG/u9D82g2m?=
 =?us-ascii?Q?oaviGWRftS9xC39W466RJR+3wvBKcZcZaNOlZZ/lN51FhBm2e7pJ3HvjJsL8?=
 =?us-ascii?Q?bKnq+HJnq1I+rp/lKa3FEKqy4S0JAEbn4vw/Brcf9rao2d0Tq1q4boUf5W9R?=
 =?us-ascii?Q?+OU54Oee/Vv0UJDS3I4aIQy61H02NOiv0nuzWOx3C5ldfdxZXTEJLUDadr8b?=
 =?us-ascii?Q?6YI4KHH5fgZ1XzJHbhqEAZP7WgqyqXNQMk7lome+vxN7yW5RqtrGVonQpnvf?=
 =?us-ascii?Q?yW6eUjCe0O+WJVeFcq2uYzl0YlK81QcdGMU5nGjGYFUgcXfe2TIJKExtEL6J?=
 =?us-ascii?Q?XdBaECG0ip3gmebqVcUv09mXpOLDyGxFZG6u/uT7Q2KJLmPKX/raNh9eWCeS?=
 =?us-ascii?Q?OvFHyKN8EKNT6LK25wVcjfZecLnFT7QdJEoH8eqEWQUbUNHipcFKsunrL+66?=
 =?us-ascii?Q?4ILLYzDTHnwIZznR8MHBWmfsbrjWNMyEpbz5VKYY2HbZVRpeL2qk+JWT648W?=
 =?us-ascii?Q?7GU1deI9tmbg0D269nct1AW5R1GklVwiYJHRcFbLehL9RuaJSxYmvlUmp+Xa?=
 =?us-ascii?Q?6DWAKVvswJ4CBfUhrNHCipG3+fwVvUhE8PJMuFWKMriefetfLIQ/PD3T9/jV?=
 =?us-ascii?Q?jPBHesIn7RjtAkpgGptZxU3GoCGfpp9qUBEO4MQxJC9x03yz377fY6MOeS5x?=
 =?us-ascii?Q?QXAdGYH9LGJGm6qG2j1QJ1miQP4aVi6sJxkqUX+DylReesB7x7ZS8AxkaNHF?=
 =?us-ascii?Q?JnxeO6fyUELGgBB082aZ876kKqMtHU82AWNSjwGcirzWHz/UdhWh7e98bpv4?=
 =?us-ascii?Q?3HwhQ1W5RLv8fMyNV/ZzDQBwTtn/Qvw6LHVc9cwl2JsZ4wglc3cY33e7J02A?=
 =?us-ascii?Q?ypZatLv+3Nxv8+JnTOtTH3HQ4FbbZnsE6TD72roUUaODfpikbWp9WYcLpESk?=
 =?us-ascii?Q?DMqBH36kKyA5oA9PplQorXts94=3D?=
X-Microsoft-Antispam-Message-Info: LLNzxEw4nqoK5o4En7Z7iZMrUfgA7aPBDGsjZ2wyCo04m9C9do4nwIzum6VWG+7ITjdSPyAwG9N8bBWKXb1oR/a2wOLfxBu/X4K3or6kt1NmSPFggoNUzfN/gUvtV4eAqjJrm9SLsBUxfOxtAb3Bnij4iIqgh+QxojqvUv37C9gl13JPFzpI5hEeRYZWD/+bZVuzZ8KNahQVPpGu6lmLLc4NJDUq5mh+Vaq69RqaGNhnROP8dRtmWvttzj2Q7iBcHTrgT6qB36lEIg7+j/i01N3baSejTN8YAH6ozzZnfQ5xxnKYtOrpjmSiG/L3QnrpJwNhS+v4eF2BLqlENQogW0ka6B8Lvic4w6vFXn130gI=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2772;6:ZWDTEzUdrTQ+UGGAeY8Szt0zBmT5OWtOzLm9XaWXznSPoP1V0AnqWdmgcaQakChO6lyFxe+pZIzIq06wO5TylqqqoSso0O5aYUc/C3+QoNWbabyQqnDN2gbQ6LVYxauL086MXuk+isNI83JKxffdvquzJsSj6OmxWhkDQQsK17V97u4ImvzfgRc6Gv06BiHs23ouYYaWZ7dnYVMpmWJYOwns6mPocDjRhNG4ErIEBGbeZneqQ5HJLjz0JxIz0F8jdTDU3bT7QZ7bsKgpiwRskEPOHdebDgEOOvh/mt/01lu0jMTmVaSZG+tZQADp+7XVvL8C6obs67Y0Y9WB0iQGG0NehH+mHtXzsSAfsnupB1RO/derFVVCBhpd1Z/ym7+RvbyIAPDvim6H+7/Ge795Ej8tl8Qkqxa00CO5NHlX5czE9Lvc1iR28paERyZvy9zCKuc9tz0uhrL28TIUGC3IAA==;5:BAi4HoePFcouqqOpoto7qdvc2B3Dq2tiLgyfug3XqSwW7fm+nyzNr6wQFCeOzEdZvKcNg/SuLLbusE/xK3mYuKTSmMBgG2JFAQjbLiKW5HFLRkP6PM5z961e/J59bY/mCzkBPpN3doPJ8vMIPV5O0qe7a25CHK/bulVXYhyU5Nw=;7:d8/01qBqgW6m2tisg/EYxNDMIjGIoHVYn1w20g0kEXE5dxm/sRBDviI2TjrkFsHZdFj1Wdr1tVWF0PrUUceOG/4McwVJr7dDZOiJ23krwvfJnXQHGJFY9JC/oilSxsZhJxXK/rUZV5xtPGoZsOCuj9B4NW1ThSY+j5eTBKmWrjzz7L2qtxZ1wCYmvFSZhtbgsz3avvbKRJCxKK4s0luhJs4V4qutLNnzaGwD/LsKfkg5ZHpoU/lay9PsnXxPzZ56
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB2772;20:uQqBD4axa1jQUsRRND7GqgZvk5NmdnkJq1K7KZbtK5IJ0clinhWt7EfplxVEtwsxDJMHvSuVwbg8s8ooypEsJvgHAARM/+dMXLItQk2is9JsBkLsaRP7TELrTjm3K07/RkRCmXxPywH7hvXfoPL5lBmdaCeqABiApWt6LysEMyE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 15:43:46.0617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e597a5-06db-43b7-ffe3-08d623c6d8e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 00:23:51 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Sep 18, 2018 at 08:46:23AM -0600, Jason Gunthorpe wrote:
> > On Tue, Sep 18, 2018 at 04:03:42PM +0300, Jan Dakinevich wrote:
> > > The size of mlx4_ib_device became too large to be allocated as
> > > whole contigous block of memory. Currently it takes about 55K. On
> > > architecture with 4K page it means 3rd order.
> > >
> > > This patch series makes an attempt to split mlx4_ib_device into
> > > several parts and allocate them with less expensive kvzalloc
> >
> > Why split it up? Any reason not to just allocate the whole thing
> > with kvzalloc?
> 

This allocation could be triggered by userspace. It means that at
_arbitrary_ time kernel could be asked for high order allocation.

This case is considered unacceptable for system under significant load,
since kernel would try to satisfy this memory request wasting the
overall performance.

> And before we are rushing to dissect mlx4_ib driver, can you
> explain the rationale behind this change? The mlx4_ib driver
> represents high-performance device which needs enough memory
> resources to operate. Those devices are limited by number
> of PCIs and SRIOV VFs (upto 126) and very rare allocated/deallocated.
> 
> I would like to see real rationale behind such change.
> 
> Thanks
> 
> >
> > Jason



-- 
Best regards
Jan Dakinevich
