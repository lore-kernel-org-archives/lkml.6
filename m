Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D412C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF4B27FA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GifF1fA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF4B27FA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbeF2Och (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:32:37 -0400
Received: from mail-he1eur02hn0213.outbound.protection.outlook.com ([104.47.5.213]:56000
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752883AbeF2Oce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTg2bxmtUGIxdF5vzLWhcJj+4EJrB1o3wKzfijy5RKU=;
 b=GifF1fA+xp46X4seypcUkCgnDcn5/jZqwpmtEAPYHzTyiIM5pz6DPz8QS5C7qe0L9LlYoXb+cEndv6a72vN7YWK9n5KA3bkn6nKSEJO3AaDY4+kLQOFsR285Ap2CKGTnONNvTuhwT7JAD3CSfnsZ54EdiO3Lj6TPJvK6f9Y8qZk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1PR0801MB1980.eurprd08.prod.outlook.com (2603:10a6:3:4f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Fri, 29 Jun 2018 14:32:19 +0000
Date:   Fri, 29 Jun 2018 17:32:13 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: x86: hyperv: introduce vp_index_to_vcpu_idx
 mapping
Message-ID: <20180629143212.GD15656@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180628135313.17468-1-vkuznets@redhat.com>
 <20180628135313.17468-3-vkuznets@redhat.com>
 <20180629101134.GA15656@rkaganb.sw.ru>
 <87y3exdh2o.fsf@vitty.brq.redhat.com>
 <20180629111227.GB15656@rkaganb.sw.ru>
 <87tvplddrr.fsf@vitty.brq.redhat.com>
 <20180629125216.GC15656@rkaganb.sw.ru>
 <87h8lld9hl.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8lld9hl.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0034.eurprd02.prod.outlook.com
 (2603:10a6:803:14::47) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b16cb0-04e7-41a0-b010-08d5ddcd1fa5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:mfszbOXFHlKsA3yOk95A59Usnbp9Y3cF3hCa+8EBvvci/u9PESIi0eYVC/tn+G0pKXs+13xmqva0kaFRw/R3/YxG0yzJhpIF9LdmU73dIYfw9g9rVr9zSX6dtCZiqnXtnAWA8KXrrsPSzQIKLvAsyQU0FXq9R5Ne3EOK786zO4i3zVHPRKuNscL5fKkH5X71gE0mrnzEu/LqR1ty0G8mzQ8x0iMJ6JP8mMqoFMlh0u9mVBEhgGI/uzjZ2fe66pJu;25:FZl76JinbI60kvpwRkiytYCporUXf6SsjUARbY9EhVMl+sNBqGz+Dx7f0zGyOKMTWN2l/DYPLuMMAVDejJcTkMeRDncgGeY0uEkbUais4ZfZKJe2W4EBuSgX95Nfr97PWvHl2KpXi0IKZhWwO3j7ds1zVVp2N2Al56zYvAt0Vt2Um1uwhnrNXQI/1nbGPYpVm//gGabKEggmhiqLwPgqApDyi59s46LHarHBWzQsZF7NlLNsZqtg4K3s7/SnCmH+ZQgxu23H3YfLxBcDiMweid0oPU9LSM2X3SiJNcfUOm57GPsYA0Zk+MAgXbCKaRmvQVw67JHvKfeypgyP/7BebQ==;31:OML6Of6e0Vm6ffWb8LrEcf4hxah4kaOEJstVMBjLFtVTKpWxKLoMUf0S29+DaMlfBw7R8e3t2BeM0rrNPXdevwdMB94yh5CJjlkFJY1/AZBVD3twdF6ucP44HyORxGEpQBzVGV5369Som2k6RTIqMP66zAEMkHF8EsBIo4G09LRHyMW1W/K/dd5D+AMO795RqSRLp1vv8R9+KXwqb9ZJa5F58RPpkzjYgKp4KtuPXBE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:FjkDfftfH9KSx253u3AEP1X6BaVk95gLjKQG+SK7xk3LOSLOxY/PImyA/N+uhZgTFxr7PYYRg3yqIvjWvG8JSe45hXeIKhkoilgVeAnRXJ+9fZy5br9N7nEoRu04JrXsjM2Ow/RcrKauaX5JZC86LZ+nKqSTnisHHeh8WZBeMoIFfXSkkaUNAG8JCKULPC9a/QqlovheTe+7tYWRYHP49gcCKhllkBUQROEGKHydFBGyqZlZa+0ucwuMMMOd894s8l8GoxDfIy2KzEtEShNm/vIZEsBFldjs1EWNj6uultvR0MKduU+9Bx/JcRRcrtjOroHISO2hjn8h7glcqLM60GLzDDlcJLzr1seMcXEFFsONRm8+YGf2t34XZHLrLtBo/6nE3MbFWsbeV/d+LByWiX28PTeA8S/XBNxI/+j2RHWNDa6Yo+1dpepMD/khEJHYEVgvkbIB9+g01tXRw7jXpOSjaeQ65zZl5lXlJlXOby98zUSUR4TfbCnRrBM71x1R;4:IfnCqo9edJwxSHDTyQhoC2DbpFyxC2TRy7dG7AMY6RN941qhgdM4KUkJcIIwmC8gzolQnJxh0XPMopMIhHypIcoY6J++8CyywaXZurZszaCvEagFxpzFbeQRrPyYhIeVtKGokYDs+UTLDAAKboEn4fscf/Dsz3uri4F1nQwf3m4FjA6H/EhzmFjsEk8fu4W79bHlvv8DVoTn9shrYd/5oaF8fdI6K69Yl6MSyLYSdmkgk5hh9AtHRSwCJLgueIgGHWGolo4FQDnrRrrYlgvzBA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1980D14AA272AD73866822A7C94E0@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(39850400004)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(6246003)(6916009)(486006)(956004)(11346002)(6666003)(39060400002)(7736002)(66066001)(476003)(3846002)(6116002)(47776003)(446003)(55016002)(76176011)(7696005)(6506007)(52116002)(23726003)(386003)(33656002)(305945005)(69596002)(1076002)(229853002)(97736004)(26005)(105586002)(54906003)(16586007)(16526019)(106356001)(53936002)(7416002)(58126008)(68736007)(478600001)(8676002)(2906002)(5660300001)(36756003)(53416004)(186003)(14444005)(50466002)(8936002)(81166006)(4326008)(25786009)(316002)(81156014)(9686003)(93886005)(86362001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:jIbHyP1WvrKju3fFzvekwGEM+WG4tVVE9JtuHvy?=
 =?us-ascii?Q?NRaPvVphsIO9ZpkcI1b8Vbi8v+RJ59bv7J9D6RC+RlxT74pUhXGzfUPdIAIW?=
 =?us-ascii?Q?OWao+u4yCKhNfo1FkV0Kf7Dx67j3VeH7qYKpZZKJpS4xe1Dm5eCC3QUpR5OP?=
 =?us-ascii?Q?Thbrk0NUEHWGonx8ErBQHD3VaI4hb+8kC/SYfIBfRgoTzZNdI4kl/PCi/ix8?=
 =?us-ascii?Q?iqvAzP9Z+2D9U4ou2/gVLhEEOy2qRVtSmIGqIWB7iCknrOnw6nAOS9ZQpAJR?=
 =?us-ascii?Q?c9E7uiy0jzhQvnAr+sWott2XFRCO9yHP1Srq1vm0t1MWkqpaJG/VKSfAqZXR?=
 =?us-ascii?Q?XuXzwgNFTcvJyldGLKclflmL5aD5RpII0JYzBMOuttdcjuxcexPjrM81xkL4?=
 =?us-ascii?Q?IyI2tXeI5I8MVofFtvmm2yuM2x/kcz2werPDw419WvIHi82ochO5ep545yI/?=
 =?us-ascii?Q?piTYXQzuLR1HPifm+aj4VEHm7q9FB8xvjNVwo9DIf/Z2A/AfP58q2Q+hk4sQ?=
 =?us-ascii?Q?EoXvHF9MyIFKNlknvFB5yWw61dTmz1pH2uEVG8PCvKNtrMHVEAFELxY21NH9?=
 =?us-ascii?Q?JFJ1aoIyROQvBDCs7uZWAKl+Q9G5IskZ6j+VeaSzJxUtqAqVBuk4c9yVagK+?=
 =?us-ascii?Q?KCCzjHqeyyickSJxmFdxzoVz1Env1jKAgrwJXwinPR3Vh0QTLYee1XZQ5TfB?=
 =?us-ascii?Q?aRwlNOCMtKsaC58nu5G3+dvv5652FhRPifDQ/fGr2STOPgFpzpZ579mJCmAk?=
 =?us-ascii?Q?gxpEle/+AGf6QWSCpswbdLUBqZEXdGyw0/2+UUTgliDg823VScIH6P5y3miV?=
 =?us-ascii?Q?Px8h8CQV3lPrF289/nl9gEZLBxKWfUNVlEhPAsE+abzUhla+g0ZY7QGjQ11J?=
 =?us-ascii?Q?hCZH2FdHy4N3VoVryE7D0Gp6VMhLVeFhpntu2qHsZ70Ads/jCIoqo2UHX7qx?=
 =?us-ascii?Q?XdgvszT+7O3Y0Wh0tB2pp362kZdfN+N5fI/BSL4yBVCXdOWs6hU0zG48/tpc?=
 =?us-ascii?Q?s7CUkeEkanBCDBBXR4CH6zv7497skgbNTpmLfEsOmH/yOJ0p1VSZ0md4oLhm?=
 =?us-ascii?Q?4jxD3TY35gB585YJKFcrSv5puoV1QeBp96IfLsiWE81LFi0Z28elcdCV47ej?=
 =?us-ascii?Q?EkRBXiVaslIxg6JrVr33M01gRsXqw02kG3XBNZvd8e/gxWbKPO9Cbnvwsdeq?=
 =?us-ascii?Q?7TmEdGZp5wDj9L5sMsIQVnsUgPx6s/jV2ehSDZkpluwnc2yJ2gzvNIZT/++Z?=
 =?us-ascii?Q?MABLfXC+e0y4mAR0n7jczAZ0scfx0qAqmtazLLBqtuqz1fgjLT4IPM2OuLTB?=
 =?us-ascii?Q?3xeoQCO7H9ubcQOmGuzGvUJ/LI7oseL1YSOsbL0oTaxz5AP2wz7c7GOI2FFI?=
 =?us-ascii?Q?/AQDsVLJ3IvLPBr7PmvuWRKX95UhqCGj8CHVKgoFFw9nfAeFflFMC8Cw5v3x?=
 =?us-ascii?Q?qKJG5Tvs5Q1dBOjZ1tS5XlqY7r/zVnQw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:efAPq+hMdQsJajaKu8rVPsNHvV88HUZidJnxdQrIEc6WVB5gwIajYXXYloEbhgvnbGDH9z9FjrqolflACHjhT5ZDaTSLLwZDm9D1tAnjjvw98X6SYkAjqBxsFnjUsIyC0hSytoG9iSDyqq+IH3DsWA==;6:vkgu2D+iyJIBPSyCrzi+XSCAMTX4nedE/K5S/udLfVr78V/GKNIpYkLNUPAhlYOgVoVv8HnCcni2fF605emQvHkDUaHfj0g6pwHCVM0vhA8LvVHTFdOugU1ljvMNhK9Ssn0MZnDaoQjKltB8ecMOFZVsDjSG1tsc1W+8Ga2HeO6wBa1eiB9KS7lafFdn36hoQLo/BOV01j2Pnm+MvJypGVdFUuE/hfYZvPPtUdnmvxPu9r2LlJU87+BJbFaecVZ0klRw+Q5wqxzAvIoDK5V5Z9wCibhvJ2x+RBBpnK/c7//N4dCKGLM58Qyaro0YhpQ9TgWw38xyYFv8SNEsbHa6un0UoCg2BE1Wcu0Y7YSHWL1HlLUZBgKouNvgDYa6B/rP8GWcIoguoAlgFntXTwmNP6dUpa6aWWUWUGcu49+MXcSOhHNR5gCDO0vB73nHjoG0Nla5ZHxNVaJbWrC7Ng0PpVjnhnXgFd98YjWaPtd7egArtIXcb7yqWOqr7Sj55Uzj;5:xtQh/Wgdl9vPOJjImqUqR/qlSgjIlC9IQFqPYmyxlSW8ksIxyZBG+NcV6xLVoyKtsTyVPyYH/SPlvsXgxHoZQQfJIro8K2m6YGjgPJbIk5yOQzjuurF1d+w6cit7Pk3LpRvUvppYJ4ofNk4aJQ4BZUc4qqgLWeVszHDR6EhSza8=
X-Microsoft-Antispam-Message-Info: cbvt3nrXrw6jbTn8234rA5goaA4YeCVZmKgXEnU2dpsHcYeqnunGvK4OvZ+1AMutIhA3Bbpc1A9C5alx58oMuxx+3hJkGRZ3ad2y1SGzeCpwHdoSZDV+xYstEPW+HHRMH1/8T+0AKfeP0xaB0VHzztJoAMw/fum4q+/IENKPZqXULoEGFtmnwPoaoKCT1xRo42yN3zAavvXBtfen7Vp48iu7BPYAH/jeygMT544N3TQ1ctYs9ICujXJW6wswiw5rBB9aOMMYNXdL/oMV/q7YXnI9bgaGw/4MiIFFMwAZboUy4JGuDBLpFa5+7ba+wG49sTgKtm2xiGRe+V9TCKCiROMQchPHvDLAZF8jxfyMUry1mGcAcLDYxkVwLMfqxf0y2yDl3j6ZZ9RDWOLLfMBGdU6Fpuib3IC3w8WE63P1BRhy+zOExa77hln1RNRBLNvJ5I2qqwuGGiAwvjL6s6TnM8RjXSwABOerECTlBWcbGCIVPtto4wi9J+GjgIb1UDbU9ZZFAmvoeNgblAbekZ4Glvt9cXtMyjlXAAj0Mve7yvQgoSMXq9fkhEiLAPiIHGK1
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:EYUMpXe7nKy90W7g5yELPe+5cXjMXrX6BSyxAUgCW7BYZgX2IrQbfBXgA9mIf/JZikTN2baZtGUwJXroaOMjZy2HeUkHjLzAg834/RXQOAVEGZREfE+hxs/JRzIJAV2jLf9PPZ0QWCe1doPNwERmH7TBijACQ2coeL9ypkAw3qjaTvIpT0WtIRIH1pqyTb3e7VbozBQFcs9ajdAK1DHJbm8pf/7W/onaXQ85xh0JCy5xvkqysi/s8aY2DJtf8vzq;20:3hw6Gl2U3A7bLQy7TJM8NZcEBg+SwzFG8UdH5oq6Um1kxDiwNl0E1LNTKQsm6Mgt+S/jvvjKee5nC7EpHbYMKKMVcz4mWjqNPp4kv83Ig/MGz7/u9/5rVLR01CvrZQNI/Z9Y7qA9I2xRUUo+c/yxIIUwzXZ+56lN1m//0FqSjJQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 14:32:19.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b16cb0-04e7-41a0-b010-08d5ddcd1fa5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:10:14PM +0200, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Fri, Jun 29, 2018 at 01:37:44PM +0200, Vitaly Kuznetsov wrote:
> >> The problem we're trying to solve here is: with PV TLB flush and IPI we
> >> need to walk through the supplied list of VP_INDEXes and get VCPU
> >> ids. Usually they match. But in case they don't [...]
> >
> > Why wouldn't they *in practice*?  Only if the userspace wanted to be
> > funny and assigned VP_INDEXes randomly?  I'm not sure we need to
> > optimize for this case.
> 
> Can someone please remind me why we allow userspace to change it in the
> first place?

I can ;)

We used not to, and reported KVM's vcpu index as the VP_INDEX.  However,
later we realized that VP_INDEX needed to be persistent across
migrations and otherwise also known to userspace.  Relying on the kernel
to always initialize its indices in the same order was unacceptable, and
we came up with no better way of synchronizing VP_INDEX between the
userspace and the kernel than to let the former to set it explicitly.

However, this is basically a future-proofing feature; in practice, both
QEMU and KVM initialize their indices in the same order.

Roman.
