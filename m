Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E324C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B120846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BueRs0RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3B120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeGZSh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:37:56 -0400
Received: from mail-eopbgr700116.outbound.protection.outlook.com ([40.107.70.116]:52907
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730085AbeGZSh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCyukUiYXGpruj8juqX8DPtdOzfoY0HxwpsU3jwT9ts=;
 b=BueRs0RBy51x/WHf390S1UvXC6JP3zETuhtRPJZxut9eiot/DFXw5u2sbRaXHuLOzgvxyVZJgWL+YJ9ROIcb198KxyWDDjasWx1dW38HiZVQ94cO20vYdluNgmnfwdsFE/TeUBoawDshjNpr4YaqqvcQOC2mpg/onllB/tqJEzw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 17:20:07 +0000
Date:   Thu, 26 Jul 2018 10:20:05 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] mips: switch to NO_BOOTMEM
Message-ID: <20180726172005.pgjmkvwz2lpflpor@pburton-laptop>
References: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726070355.GD8477@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726070355.GD8477@rapoport-lnx>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:4:16::22) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f556c6-5ab5-4179-794f-08d5f31c08f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:rdwcnQ1vuqYf3crSe5Id+jK1b4FUXv0xY6LdG75eVYbM/dMiIbfPinUuAJ2VsfLMJ4XRTkZiCsQsed4YJjc/88ELFMWZUffDoB7WJotURIGotMiOF9t6+uXnA7ylsc9fXs8CqyOvXrISL8WY0HjSjgTatWNgyFDA7Xcy1+HWYHyk5QygE7fqcmKrcp0BWnbO2Jmx3D82Rcev7GpQfF/DSPMzGEyHT1ALrXrhjoe8sKIiolYOPhF0YLpn5TfjTsyv;25:t3P12F3hQfqkEIFIkpn7Mtx400Xg9dA4Jptf99jXvPklx4ZNORWuGJ0afSE4rpTYf0kHDgM6CxrsZ5D6t+5KS3QqDHDHZVoXkfuytMgkTfcBWiUA50U5RxAyNPLj3kxReAqM+920zt4ygwVZMWtye4AuskqoJEyA41Y2zEbauN384TY4MX1SYq+viRmAsLLgoP0cwIlEAWVbvtnoKabVKMEPE9Kf7WQuwz/CAVs5YWbbb+KLAyuzFX2c64915H5zEK/g2ek81XZqyfJ5UmD+cl28FI+hklD54ngyUgQX7FWh8FM+NACfaVgd7jZDwN9LsBYnlhlyMQT5oEDtn+9bjA==;31:MFITRgUwi+Um4GYpfyDknFloN6eH4+u+DV9o35PPFlST+rGAT1OJ4wPEvj3cBLGNiaEjt7H/VjOmlCZMVszj2sHVO4fjzY73CkROxUP4n26l6etYORz1zVfs8TYZ/LiCCmoGJKShC5iUVp/wQMXybsjbcniBEng7WpeM3O+hZAWV1YMovOvHGGwaG1koGKzgNaEQMSNfdO8Wf10iRDKTQUfC68vcAKhPN6TcdqjIvqQ=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:1X4s4NG3XGkMo/5Hd7xB9UWYbCc8vd204amZcMDLIZi33NTc86I2PeL+rfhXIR5pBYnMnybgKcIdNxkZ3SbGErWf9d9BINiw3UrxbIkwz1LRIsILprsfBd1R57pR2x8u33vq+XbE7fpA05PhYGMKPUc0ZP/RxOlqwdiscL2UT9y1AYMwWYUvSwzNby8VGnwENU3FNgEfWXAwIFHOlH5OeyFv8F/TQfsWBgv+UK9u8OKixUpJZwgpAIrfk2YfCnD9;4:sNPZJxqjLAVk9L6O5oq0/bUb9x/FeyrYUiVIZrtQPsICy6FS6cCFAvpE5RBxFTddC0P1CT4qsF090JbccMUfqGGdHeSeg324g/I8iElLxv5lV1f+5RSCgyTwesZfg9QsIhERP+Bo+Hjk912b9vF0+Vic5r25InWbvHnd239ScaSxfomL2WgsWCMExe5t1D6kRtLt1dTi0lHs6m0kBJCDG4iuGJX84B2vYBP9g7mouU79aKMwqNkpIl9IlWinIZYZgZo/1e/q6C5Snac7cuIz/A==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49363F47B42A319105BE2FB3C12B0@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(136003)(366004)(396003)(39840400004)(189003)(199004)(956004)(52116002)(6486002)(11346002)(47776003)(76176011)(6306002)(5660300001)(50466002)(446003)(476003)(229853002)(66066001)(68736007)(33896004)(16586007)(9686003)(2906002)(81166006)(8936002)(8676002)(42882007)(76506005)(6496006)(54906003)(386003)(81156014)(316002)(58126008)(305945005)(6916009)(106356001)(1076002)(105586002)(186003)(966005)(3846002)(6246003)(16526019)(6116002)(33716001)(39060400002)(23726003)(478600001)(25786009)(4326008)(97736004)(26005)(486006)(44832011)(7736002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:dGWL6qsIjLEX7HWxXf/y2mZCHOC2w/nK5tOQp55jf?=
 =?us-ascii?Q?RyNhwArVJrHNVWHGx1P9et9Q80MB8KPhCxsrxrqxYW/CkmtONzRpKWDRqRL0?=
 =?us-ascii?Q?VHbm3dFJL4WFF4BVHVawHG3i7UqWUiqFsdg/cb5fqlr3cymxqMHf4y4ZspEO?=
 =?us-ascii?Q?NwnwZ5OBuHXQ0rTa88RC8AyWrV+TWqC/IvaCgV1YwG93PUd55gh/Dwys1XfW?=
 =?us-ascii?Q?bQVxtaXZeJoRPO+CNHXWjXqT+GauLNQ7EFeepmvHQ/b0WdzZwyIFJNFh1l7J?=
 =?us-ascii?Q?HmGXRaUbqO8zJtPAoIdN4Pwpd7PpYXBl6ppYnwPRJsJZfC1254JEGYWrH+sW?=
 =?us-ascii?Q?qGYBGJsIQMgAR7uY9ucZChpsHpbR4Yuoy5WU9GmUXNpcoM4zcrQNaJ6atY5S?=
 =?us-ascii?Q?9HntOKikjQtULyMaxQUbEn6VyjsrX9qV1SUh12M1Z+9vZsoZl5zERaS6DpTL?=
 =?us-ascii?Q?OX/E6510eNyWWi4VqwS2tOiaG4s9A+SH1F/GBwSGgVDW3y9obMJH77jdUykz?=
 =?us-ascii?Q?rv7jyF+i1FW++jUWYS9Jg0OvPg56I5tfW0ffqfQX0naIW0t15HMTmy8n9i46?=
 =?us-ascii?Q?SCda0jerXIbKMCTi3VMd9AAAd8FCbzxJ6K2lQau8ibf8VEReutn8er8ErtJa?=
 =?us-ascii?Q?Mzkb3qR09Ymh/6yFYAxtuqbH9/WmIuqAAIhJYjisz4/KpVK1S9ugjB8yjY0N?=
 =?us-ascii?Q?EvqoWY10M4j+iZspJgEhzbKzn38d2dFMLiqspWiHisJ2tKPfqlNOpRc3LnmY?=
 =?us-ascii?Q?V3OXvODX7SfqeYReycz/o14ZsuJ7vnZ+6JRGUva7E4PsLH8m6O5Vb51+pPdO?=
 =?us-ascii?Q?CZLtsC23wLaVaHrVVF4IgHzNq0qpMw8lfnPC3FT/ymjd4bzqL7dvGTRw2LkE?=
 =?us-ascii?Q?rewHHD/JhmBk+oZd/e0DrnNlIpnXhxxsih4mbINmilkYZbuUrMdQEPe3sjiL?=
 =?us-ascii?Q?ex0JWyyTYB63xb69NuFbfEdkkTeAU45fmxEndmW9M6nU1uKr+XWDAfa+a2ZA?=
 =?us-ascii?Q?Qsixbmt1TFPiQN9qZcqx5eutHD2xFW1jsWm81SFdiPC8wlmaxSY/CwIccr70?=
 =?us-ascii?Q?KR2p6NOQroUS2cpBurreg4UJLeUYg+v2y6NdLtHcxd7A+qOdft9d5Kgi9tup?=
 =?us-ascii?Q?JZEnRp2isn+G+l0ADyt+2WSsMY/OH+rtzDFNKRJDBVTuK3g5t70taWL5x0CD?=
 =?us-ascii?Q?3U9+GH0YDBdIsXcPFwjT8gcWloz0lj1ZmqQCkLrez7K7Tv7jkQwQ8h3WK89+?=
 =?us-ascii?Q?OpHJ112mgdpF0f7x4TyXxVY3XIe1K5/NGlf8GW2G1Ir06j1+cRNbOmiS6DNz?=
 =?us-ascii?Q?thgyy2PrEGqZWJ3Z0bs/WGlWlfAQeH15YCQZ/1UnNsn/I2Jcd4dVuJBGHBdu?=
 =?us-ascii?Q?Un8hw=3D=3D?=
X-Microsoft-Antispam-Message-Info: s7hf/8rvGGqKMrW97MMFrsCZYg+Hqo2VF17VB8YcwKbjW11zDd81tC6Upg3NPi45JcB1ypBnYy++zHXA6I5DvfTYQOr/PBHLxB0ED274PhmrC9K7g9G4gMCxu87Kjh0jKSq+9iYRb7qebnIsphZc+PVCrqqgkYhFXWup411gzHBAQlME08pdR+EcnLcCchm65EssvzDKGzcGvVuV136Zs8VYCasERYRZYJbsksRIR0RYkScGkbYAvWSeeSniSTrFwUY14Yk3qcmt+iP2rFbtECGFVX1U5ZTS6nzaEG+9A8ia9LccaZop/Dy4eJy/QUW7aXMJDmEFRCl048mkDk/pK5uoATKB8U+GbM21+r4Yve4=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:dywUmUf5hhqIj6EabaisVLMvMh1yPLzQV/Q06446JjzPnpuAY52MEfazWZMRR0UuzjiPtJrlxmFXUke8ZKSGeW4IjIez9qovAvBza685Sb5m9e5ui3U7l4ylg+PzW2UbHCEz2JsTyaWhdTNM08jRhqY6fnY8wKcMc256vtuzy69vp/cKhIIzX54a8NJ23AbtdmOOXobmcFQjphdy9/GyyO+D83rM6Qhgqp+A+A27yZoqu0Mhm1h/NRmgfEMt33L0ZoFv9VuorB0tjiTF0B1MNjf4FL3DGHOLZpdBcFSnyTDyoC7l/3FmpHzGbeY9F0BJJhEpjbIgMer8mO7X+PVwsXxJhHdgwo/i9DGOI8+3nEix8Dpq45raHtYMSVOuW4ER9wvtOEW2iWWW4ZZsQfRo6qgo+GKIcX6An7Pigzl88j3o2pzir6fdZ9Tj/iCvTpUAsqXG6xeA9Gi6kncyVmrY7g==;5:qOtYUVEq5X1gTdyLedlg8QwGsRYos+yJigVDR0O4bKOtqnaY0AgcG2DstqY2nZ5yv4gyJMTBDbuzZf3frNy/mOkEXf8HumWZz/bSoG8OxLTK6zmBUYqkTlD96vBDJhsTbhgGBqyD1Dqwg4WdLj10KChfCIaO5MFGvEDtNyXdSx0=;7:SjnQ8m0PyIGf9K1RWbXvc7xoHoQL1UkLSinRLeuZpYgBjJpDQKKpmTCekm2pAbv0J1dIXjtI7+h4kdWosmx+SGF7aMCp1JFahJDYdAFoHUbUYiwoz6Av4j70hgUFtJKgZC4XMf2tAsaWaccTwZyEFUPRliu22bSjmCG3BipWW2xmyrLZAqql7SYhMGcHIkhnZ8O93c2fvrrR016Cy13pydbJbGxBT5i9ekBeqyRvqlwpwfQnxHRVFuvBqEFB5NZ7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 17:20:07.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f556c6-5ab5-4179-794f-08d5f31c08f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Jul 26, 2018 at 10:03:56AM +0300, Mike Rapoport wrote:
> Any comments on this?

I haven't looked at this in detail yet, but there was a much larger
series submitted to accomplish this not too long ago, which needed
another revision:

    https://patchwork.linux-mips.org/project/linux-mips/list/?series=787&state=*

Given that, I'd be (pleasantly) surprised if this one smaller patch is
enough.

Thanks,
    Paul
