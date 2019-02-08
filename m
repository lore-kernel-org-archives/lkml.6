Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3B3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A675920863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="rlzOiA1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfBHRn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:43:58 -0500
Received: from mail-eopbgr760134.outbound.protection.outlook.com ([40.107.76.134]:62784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfBHRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGVHzvsKEVmrXDg3WQPlo8xFoIPAF2jxEM159a4glRg=;
 b=rlzOiA1WO2n9UZotVgPr+oCNAmhXmOAodgj+pADZBubwZ0HQWhoS5jW674Vuhqz7q5KVX6Ue9FWoNq7QMSiR34/6tfM0hUoVfcNR2XXuVAKazuBmgnrDG1NYz0FZBxhOXVFrEqsW4XhOQq+bPYDMneyLrPd4n9tEMp5VtUAhZIg=
Received: from CY4PR0101CA0016.prod.exchangelabs.com (2603:10b6:910:3c::29) by
 SN6PR01MB4495.prod.exchangelabs.com (2603:10b6:805:e1::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Fri, 8 Feb 2019 17:43:53 +0000
Received: from CO1NAM03FT058.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by CY4PR0101CA0016.outlook.office365.com
 (2603:10b6:910:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Fri, 8 Feb 2019 17:43:53 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT058.mail.protection.outlook.com (10.152.81.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Fri, 8 Feb 2019 17:43:52 +0000
Received: from callcc.thunk.org (guestnat-104-133-0-100.corp.google.com [104.133.0.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x18HhmE5005004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Feb 2019 12:43:49 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 098FB7A47F7; Fri,  8 Feb 2019 12:43:48 -0500 (EST)
Date:   Fri, 8 Feb 2019 12:43:47 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v2] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
Message-ID: <20190208174347.GB23000@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20190201180831.19839-1-prarit@redhat.com>
 <20190202030240.GA9802@mit.edu>
 <4adb711f-f81e-31ef-c581-4d5ecc739bd1@redhat.com>
 <20190204155535.GC9802@mit.edu>
 <ea4c44c8-a6f1-dac2-7cf8-a1a0443a39f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea4c44c8-a6f1-dac2-7cf8-a1a0443a39f0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(26005)(33656002)(54906003)(42186006)(16586007)(186003)(316002)(786003)(36906005)(58126008)(75432002)(76176011)(446003)(23726003)(11346002)(229853002)(106466001)(106002)(305945005)(8936002)(36756003)(336012)(26826003)(7416002)(50466002)(103686004)(14444005)(8676002)(88552002)(86362001)(4326008)(246002)(52956003)(356004)(47776003)(478600001)(6246003)(126002)(90966002)(1076003)(46406003)(2616005)(476003)(6266002)(6916009)(486006)(97756001)(2906002)(93886005)(387924003)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR01MB4495;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT058;1:3uDTdzxigFgK4iCBskty5aIgas4Lb6KF0OOlp0F33ayTX0xglqeOSLMwIPyljki7RJn7SmkIL7hGUZydPzS1J3cBa8Vzb/lKhr/4en0M+1hSLpoz7JF/TgT2+QvylFhpK/UiDTzW+De0dcRcZPuvFkKxOAb14N1CYKBngAb45n4=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ce2975-6fa9-4ba7-ea45-08d68decfe01
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR01MB4495;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4495;3:Rvu8/mQmMOOPeRLCFaX4ISx7aHvnytheygW+POQj86pKDVuQWaCWBGfdf7U7LQCluDlal2QIIVo1/YIqssGJkugc/iPej7u3qdEmi34eVNJkGxfkQFpXqO17353VdjESbSopcqEFHIT98gE5i6DGfVs3ZRgee+gqh5+U/6DEKOZ1Xda5sifYqKSjDMTeCPaMvdt1cxEv/vXGyh3TkrT0r4o4QZ+/7/dQoUpdrzUBhiwGEnQG+SC2ZPMbIbsPu5eAFYZrz+VagbdYRmNKwF9ikMEoFYWiDSWttTIwD2b/986Dn9ZKLHkdY7kZ2xyCM3PU5fbmcVfGTobpFOCpSWpFaoEdjYq+Wnee12TNFEVUoahfIEgtUX8/C37CEjdTJS24;25:33dtBjP7jel3uTwqOHxNDZq9AFfcNJOx5pO1yN+Uo40wO5eP7V18WmrAxq4epuLOmQJDLyXLnKT/iBj/o5qwChHoGPYR98P+6KLcFBdDBSTkyWxnmjEFiYkMMjtvE4/6kbDo0J++jvrEOEBWHuylBCDS8/QqZbSHSVcWnmIpsxYOcDE97k52fJoc/6CGz7bXk9C+hu0UO5OsDnhavpv2vP9785Tzk/zVLcbxceuu3MrKQ6WH1ePqKNUovnrvB8kk2sQ8UH09oYEA8TKhd7BVTcSDrFTT/bVLcnYxbIFBSM4/5krOn/exn6GIYFfT61VnCiwMTs2E3IjsOpFic3pB0g==
X-MS-TrafficTypeDiagnostic: SN6PR01MB4495:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4495;31:RfyL73+dwAsL48AaW4o7zrzVbs1e/P9UH7CfqgaF8trBa8kMwQDLS5WBg/IB0D4l6oSDZlPzAYKgJlzlR8CQZxvhL3Dbugk1dI3AwJuBFnBVrgVqk0LGjPO8LnNlDHCb3afeGgCnNPIPDKg3Xiobnqmu5F7NowKxaLtFGw1Bfp2xZYob6v0B8hkrXxpa0b9GJG2IfcsxLZ5CjE1LtBD+dNUs0AZsoVtybxAuGwrWJbU=;20:2JzhAoOaOvKd3FxoQ9OQq0IKiBbMA/jHvR5b3ejFcpwr8v17r6IuYGZh+8Axh0chbYrLAKm6NTvURuZozPLweSaTb5I0Der0tnp6NqRWB6S8Wi2KXBKdHovHQ7grIwuNMOInRHRJUBBj+of/QDkHR60xinsawl2ZGP3VxKbOJYjtFgnATnYtHLRpLNJFByU6D46ekB2rtzVNh2B1bt1btuVOejcDguBFnryDlc5vgcTU6z1Qz3sdO8mNyMcrSv7RYBUyV1iJlbRyHYoR2BVKRXoUNqzksgnLs8S4GN074+YlN/0mXBkyCIKwpPY1ksLRI77NIb0HxdbdUgerVbFZFJd641Pk4qfq3FYgNBVaO5AySQjAVIsnqvlP/4QQ/RWf8rqhwkuHKEPJ36EhtSTXN49t4LgwNjBjgNR8Q53WxLu7KHx0IsCW009YoGtSGbyAeHJ40yyaIwbFUUqgo0kynWwVOElvuwHsIfUj7BHrP4owIQtjIIGE5jj0WBxX3PJspPMKHw4P9LDl+At9SSySKcICaWyhOQt9+OSmuAJnFX8F/TkF3QABcy4eW39A0ZmefFsBnJ504thGy8BCf/BV7gCh6JALfEe4fPk8PkK9+EY=
X-Microsoft-Antispam-PRVS: <SN6PR01MB449511B2E6025AA65A8C375FB5690@SN6PR01MB4495.prod.exchangelabs.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4495;4:qSnFSq3eo98goWlkdF28VXihoftvYnzRQZDss4PyyDB03+L1Dl0ZtB5KePm4DthnAADUXecQqzwQ7hVoZZbDuO9JJzET6MU0xOomTfuzu9OiA+jlc0f2Lo9xLW0K1DklTb+yRXtPCkkWcQaxqUitjQQdoKVZVgtGMgFr5yM8xKln7dWN8BMPWJQoWSiULPvRliesb6EzjtMA+ZmVaLPDg56a1aIFs49K+sKZ+HDypyVbZ+VG4jAyNse14c1LS5xO8LtbB3Q3wd50biSQ+3isI0AQFXEpOmbNF/znaWxjYhY=
X-Forefront-PRVS: 094213BFEA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR01MB4495;23:0Iu+IQF+qj7/1K/mEX/Bdh38sWFpvpFVLl16uWRtN?=
 =?us-ascii?Q?Pcvgr7cd2rLUsuzv7upFrBn2DSoIREf4384RnXUuNFRJyj8W/PR/07VTlXd4?=
 =?us-ascii?Q?fzOioRr9WLF/VmFtjrTAZ5Y0jKIYufwKJDOK/FBEkYe2nzyz6y2DqTeCf1Mf?=
 =?us-ascii?Q?pixFy1FUNnoT3APyTS9ihJmqU0ksqSRExReUymcK7h3SU7l2ctYckozcnHsG?=
 =?us-ascii?Q?ejqlMoTiTSjJviwZZp1Ddjb22Xw0nIsRBSY3QtQubpoWhpOeopquLdtnkqDa?=
 =?us-ascii?Q?einp8LkWL8N6b//h7COSfAd4OWEIhEmVlZ9H5YER6Z6LHY7BJDztBntCg16z?=
 =?us-ascii?Q?lf+TSgVlGiGwq2hNyxnX62TbKpltpGpR3rsDMbGqk/ZtUSM3hJUaXXBpoeC4?=
 =?us-ascii?Q?FQFHNqewhjAxNqHh/nqRjmSWf6aPvbZ0k7KnUUlMpwzNAsZaWhNN7TLqnTzH?=
 =?us-ascii?Q?9IdEJNReEXeEo2wyGppe6H9eF1dSCK9vvYFaKl/NYaL5yVsi06NS5fm41BH2?=
 =?us-ascii?Q?jfi5FEsZAITWrxJg6wyZ5vQomnc8dwhjGzcS3KvWeHRhYbyurdGM+TwyECqC?=
 =?us-ascii?Q?a9ksITv2vhAj+XDvG9hA4MsxDVlOTeBdJgwX4b7Bq0jG4RVM3zbi6s+RWPoF?=
 =?us-ascii?Q?Y+RrZ3E2GFxhZdf83M/L2NMuYji8nPktFeK91qHXs2JZOpitaDODbZN0S3Lz?=
 =?us-ascii?Q?hRKeOQnWzYdobTFXOU8TqtbEIjkuD2Z840q3nekoYKP/FuHhozohwZTxtUXH?=
 =?us-ascii?Q?N/QYX4USI/SIGaeRca1bKHlPaSQR1Rx114+dlxE9iwt0YZIw8ghvAmd0qMFk?=
 =?us-ascii?Q?dHuK7lBsby5hwWm47kWt5ZYOMUL+LV2uxiQP55gnZN8LbMGUJ2RkXQc6BsS1?=
 =?us-ascii?Q?FSxgs/ghR/V2SvL5J7hx/IajE1Su3dZzDlqntpX9kHKAhh6QyR0Sh4BiLiPF?=
 =?us-ascii?Q?OwH82fnKO7DPDReiAaq9TqQJqOomE3Ulclz3QNOKVk9HcILu/b3Qqck4uSaj?=
 =?us-ascii?Q?wOa01gKZnvXXpV8TmiSUb4KX5ZpMkYZ7Qa0bQRwmmd498mKzo4BxnQjnL2p1?=
 =?us-ascii?Q?Z0I4NSrRnp7yaqZNcLdje3XUzXFWfqTJ4e93cGmBGXUHoDpxmsoBhYTNgUpU?=
 =?us-ascii?Q?x0eTHRQv23kxA0ES6ub1QN7wfJko2bS6gMd537es5K5wUCxKjalx2XVkvnfr?=
 =?us-ascii?Q?+13jRmrYVFLx84sOVNRXTk7wBcRDz6vc+w7Cwd0tazTDdU4Dvg/VdOGCsA0W?=
 =?us-ascii?Q?Bb2tkDSCqY1SOwN6xg3t7/jdkaDv2sXY+l41Dm3o+Ed0lmNb9KuKnbi1S+DG?=
 =?us-ascii?Q?sY7hmfTB1d8yjMkn7eulVw=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aoQA5SMoUf+LmjiXDMvgRC4lKUfwLtEmqc513rubnvnzdo2X8JmQLjPqC//9W4zocdae1UNFpZ93XxCuW167KvnDUZ8EZZ45jsM4hHynntiN0lT+dkSlpzsOD5TWmUWfgvf3K3Pfb7+lAUUyRI1SSgdBPBkGHskOxlk3tApilp253dWhnhsHVyHe+0D/KHBrVGnihvbpGl44EMi+x9wX/3ECeO+K9M8wVz7xvAMKWC6c7yVWuY+kpJJ61oAfU84JnPtaSSZ4w+h6Q2an6plWCZOBsPHkH+0VUPCo8eEU+HnO4xaaesW4NcEADI11R7gJQMBAMw4KQpMyy/ITY/0GQdq//jKeQbmChxmlWgD+lHnL8sKl3dNBdar4tcv1mE2eLz51hWXD4LQGrjx+yVPawfbWp0Tz3p5rMXw6rBGEhmA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR01MB4495;6:Ql+1Z5iFF3kVSc2hbLh+KDiBXRxOpSzdUfsYKORYGfJhDV4ultJz12uZpZbV87vusTnVaIwVyvdG6zg4UXOBQbkZ2qitu5xvfl+EGGdNsa3goA9CCctuxTgaOtxtvMG7ULe16ZV1sAFb1CYWiMF9pR9i/bnvtRqQs1iwP08TprwBVan5/PJbx7K/reAU7VkV20p1Sg9nSI+2icakvkxTZn/YUdh/0RugxmWzxCVJOSMGZuL6k2uyZPaEtnS3WHGJ75U4VKrATFGcf+ZiDUYJAKMKDyvzI3RHRU3lXt5dX8A8ogYKoBphLGFPmTxspgJWdjfWnDHGCvAtq80wy3R063eH1C6BcToVxofPh1Dnk25UlQdAICt8DzezczbvCr1HBltp7mlBfXqjDI3PLiMax5XYFquuJ6i9fEG5GV18K3vuKr6pO4dnwTfG6n6wV5FysljsN5yhew07phJjhBb8fQ==;5:Qo66rbNymnYUZOQFTvC5VoRpO2QzW+idUQgV34Jz4jUS19zUgRq6seTN9ldhK8VER/aHgwTSp0Xj/Oamvo8/7VQnuqbLwwiIZezO5agO8biyf51EI/NIlFGe3q9aKn5LVGYOXSd0yN4B/oF02KYb+G0TC7sJDM1shiHTQsd0pkqMASIyZaETdp/MrjWN4iW6KXDwaDwgAnYvSABouhvf9Q==;7:45GCGeOurdLqexh7lc5k21JPHb6OuoicA+kEUL0qj66aBf9TQz5ZmYZPjuzLumOagd5VUnn4j8IIh8mCwzmsPk5XbvKGYama2PAmbBuYekTxj378sBRlGV6xP+XORkYwDVu5ZyDmOW2kSdxet1itgQ==
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2019 17:43:52.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ce2975-6fa9-4ba7-ea45-08d68decfe01
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:14:45AM -0500, Prarit Bhargava wrote:
> 
> Yes, that's exactly the case.  During early boot we initialize the boot cpu's
> stack canary at arch/x86/include/asm/stackprotector.h:75 which is well before
> the random driver is initialized.  The same code is called for all other cpus,
> so perhaps not calling get_random_bytes() for the boot cpu is another option.

The other thing we can do is to build some method of seeding the
random number generator into the boot loader.  This is what OpenBSD
does, and the advantage of solving this problem in that way it also
means that we have good randomness for things like kASLR.

There are two ways this can be done.  One is read entropy seed from
some kind of secure store (or at least, trusted store).  This couldt t
just be teaching grub to read from /var/local/lib/random-state.  (But
if we do this, as soon as possible, we should overwrite random-state
with new randomness the moment the CRNG is initialized.)  This is
basically what OpenBSD does.

The other thing that the bootloader might do is to get secure
cryptographic randomness from the boot environment.  For example, UEFI
has such a resource that can be tapped.

Either in the bootloader, or in the kernel, we could create stub
device drivers that try to connect to a TPM or some equivalent secure
chip (e.g., such as Gotogle Titan chip on certain Google hardware
platforms) that doesn't require bringing up full the kernel
infrastructure (especially if it's in the kernel, it can't depend on
kmalloc, or workqueues, etc.)  This is because it needs to run before
we relocate the kernel (since kASLR needs secure randomness).  So
effectively even if it's in the kernel, so it can more easily updated
to support new hardware, these stub drivers needs to be able to
function in a very similar limited set of runtime infrastructure, much
like something that might be in a bootloader.

> Perhaps I'm confusing you by changing the comment.  I'm not changing any
> behaviour wrt TSC.  The current code "relies" on the TSC as much as it did
> before (all the way back through the git history).

If we are only relying on TSC, we *must* not silence the warning.  To
the extent that your commit description talking about silencing
warnings, that's just raised all sorts of red flags.  Maybe I
misinterpreted your intent, but talking about relying on TSC is just
the wrong attitude if it's going to silence warnings.

Warnings are not necessarily bad.  Warnings can spur people to make
the kernel better, and in the case of the random driver, it may mean
doing work so we can improve the quality of the entropy that we
provide, especially at early boot.

So it's not about silencing warnigs.  The warning is a hint that we
should strive to do better.  It's much like pain.  Pain is gooid; it
tells you that something is wrong.  If someone has broken their leg,
the focus should not be on silencing the pain with morphine.  Maybe we
do need to do that, but if morphine is given without also setting the
broken leg and fixing the underlying problem that triggered the pain,
the painkillers can be worse the useless.

Sorry for really harping on this, but the philosophical bent which is
implied by the commit description is something really wrong, and it's
especially scary if it drives how we modify the code.  Please, let's
focus on improving the quality and the security of the randomness we
provide to the kernel --- not silencing warnings.

Thanks,

					- Ted
