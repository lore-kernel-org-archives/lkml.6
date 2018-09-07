Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0C3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD1D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ViCUtxOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD1D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeIHBoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:44:13 -0400
Received: from mail-eopbgr710108.outbound.protection.outlook.com ([40.107.71.108]:29517
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbeIHBoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SELzcDEG7IO2N6D+ZUy6Ix6mBEZGdvIWDfjS+CGU4ig=;
 b=ViCUtxOEXqLcAKW8BWOFr33WxM2E4V6pJOGFwiIt0XGKzjCj/xrJYonugw8txEluzH4SVLl5wSfha180OyZ9bRE/zWOwYIYzCcY2JfJ/fknlLeFm07xvEtVR71NWD1yslUnVc+H9zW1GfCoaPZ57zOQoM9EdCbBcVo051bP42FU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4943.namprd08.prod.outlook.com (2603:10b6:805:69::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Fri, 7 Sep 2018 21:01:26 +0000
Date:   Fri, 7 Sep 2018 14:01:24 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] of/fdt: Allow architectures to override
 CONFIG_CMDLINE logic
Message-ID: <20180907210124.rrqbexp423igxbsr@pburton-laptop>
References: <20180907185414.2630-1-paul.burton@mips.com>
 <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:4:16::25) To SN6PR08MB4943.namprd08.prod.outlook.com
 (2603:10b6:805:69::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d5d999-f64a-41fa-e564-08d6150513c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;3:lRtff9PUl9kNA5S9RCzGTBc9WoZQX/pA4eZYX9nYjKGtXAC+BiiPnKvoC1GFrsnCFi758p1do5SBn6OS8u62PS7ktqKVjdTnLWdONLmPSfOVdawKax5ZdZxwJdBZ+vFMVPS25g0E0HP6OwGGNK4uRIdNvJ90mtGD+QhF+es7RRzMh+nnfawaRxCla2kc7pWFX32C0uTIwgaWNgld9Mm45GxGAiRGamaGxVVNyoHS1f8c+Rk6XP2vriQcigPo6tMz;25:rFmSfg7PW7yDq8qCMHHnvLipB0qTZ5MT2wZ/+twHASgMeIIOVYrR2H04m/BYu62lLVKz1T9DsbEL9T4W24rXkyanwvq5McabyB2Zpa6aECRyFPc4OeZcPTDOLqKgX3IC58HjAE61JZLbQZUDjLVlszoyrfwryKWOdySGbJpvJz1p9VqRDvviJg1NOYMW3flY47HlesVNBrs+HCjGNXAzhJoagp0RFV9a4Qu+CDCC5rLZomX4ZL3yHcCajfNTto9nAcezEfXkxorh3mp0VJZwJDFWswpNQ4dSw7XoJvrW+UeY9MWVK6CEeLWANm255QbiIl5ZxGTP1VHTcXAQePApiw==;31:KdlR9tTqBDRYxVMugyWpOXFABILs0nbrDczm/jpi2Mx7hnGGORqgD2A+2JgmiYfv7IvrFDm9PFfqk4jqLg7S0pkT+lJpI8QGeEhHFDBhQJSwnXMO0aCJbx34ZTtSHtaB2TYWX09Lb0xtIAw6MUx6qCJnxmJNOTd3S4MSCC5DsE6G1uvRxKAHsd/aOfjYsK3P93etvCpT4TkG9uHRuopVsahRZaMF1ywnwgNZwUBF+Jk=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;20:krF+9oqGGE7Acb3Ok8qTA6dakwsBECiLqjdWtRbmODrAaKwZBtx+2uuEvO1jEm1P8dcUu8w4rZcMFXEDGD4tzVFlxfMVmhb8AGGNjrLzEuQ8wG6ojF1jPRntu/CzhqVoELe7Gzf3hDWYeN55ToKgkwslxBNZQKe5P0HJ3EQJQhucySC1+5N/3SOpqDUF4VeJv51YN6vdG21qSW+mlqnb1Fx2Q9mWHU9G2n3YDZ2dl5uN0JkOTgpWtizIgdxLeej9;4:8lqnSK4L1tGJJsZZ6unKgVEpUWizUik3US5/FCmi3euP7ZqLa8PV7xipR84r9srOnewnLgLcAXVuLB+UisJYUtrYVuxVAJBwhaP1yAofhAx3xweV03vEpOCHf1PUWKtmkgCX+0pnuqJVbS0Rpg+4lWs9rqcTVq7qnOy9VmtDpursDkhCklz+EErvTcjwwxwTiof87J1tbDTngtHQIXd19DFrKc+6RnKDybGkXMHUahubraGobb54fF3MDwZgm2k/87ED4yucMgXFWVPZMrgEug==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4943C4FF981451C99E8A80F8C1000@SN6PR08MB4943.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050);SRVR:SN6PR08MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4943;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(396003)(39850400004)(376002)(136003)(366004)(189003)(199004)(25786009)(106356001)(478600001)(105586002)(7736002)(305945005)(8936002)(81156014)(23726003)(53936002)(6116002)(9686003)(3846002)(6486002)(8676002)(33896004)(50466002)(229853002)(33716001)(68736007)(1076002)(81166006)(26005)(476003)(76506005)(6496006)(39060400002)(4326008)(2906002)(6246003)(76176011)(52116002)(956004)(486006)(186003)(47776003)(53546011)(16526019)(16586007)(58126008)(386003)(42882007)(316002)(11346002)(54906003)(5660300001)(446003)(14444005)(66066001)(44832011)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4943;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4943;23:AWqGDTMj37kd+jCvdhUJ/u8he3rle/f1lzzfWMVmo?=
 =?us-ascii?Q?bbsjkHmH/z/aK78zUk7zuWSn2a5Ye9o9ijPmkkTsiLJQP7YA9B03hWIW0PCK?=
 =?us-ascii?Q?SWmRnnvZG5yOflgcGT873Pho/ZN3fIcd/kvXpccjbtzggPGj3uiEZDk/m66K?=
 =?us-ascii?Q?IJN+ecXLGejcRlujnxQ1inTCN1xLnmg7e8SifO6+wRJN+0ZFnd4JtP35wGbv?=
 =?us-ascii?Q?9Q4QguFKg/jblr79bkF2kUh2lNiGxe5uIGfcQDkNSa0lIOS3aN+eV+8O5lvq?=
 =?us-ascii?Q?T9Y9/KI3fm8uF7JBiG29+zWcgljLVEQLx4AIcwzERF4GS8emWuu0fZSu4J2Q?=
 =?us-ascii?Q?4udQua1ZuV6UCKC7jtKNHWd5m2iVUrSeGVrujQCP7+M9D35zJszMDV4799mt?=
 =?us-ascii?Q?HZ5UVsp5oMAa/lgZP6KSxGjFX4DQQ9HHIHnP+UPRvuDLKQf/d7MDiHkZqP0g?=
 =?us-ascii?Q?sbzzlh2MZxdJXlE1W4WzCJhvzFftVbs+QQiSxR+rbmpeXIvDJQnvPajkk2TR?=
 =?us-ascii?Q?98vLSFv4fK5r9AfhPoRFXYGvJAH8/zrCQeX2jiPzqQDxvD+ewOMD4OuiiFqo?=
 =?us-ascii?Q?nFAiY9mnZHrQqDdt+tPmkfOxZFWK3LewEm1A9k/fsjtgqS6tbvmZovvdIMoi?=
 =?us-ascii?Q?E59gtrHfgJYJzM5Uyk+yvAhczDy8Rl27bq+vHqjEJAm64pAfJEEDqWtFQNWA?=
 =?us-ascii?Q?HDVA7wqD05nAsrIX6m0t9qPLMEaOatz2Ha+9f55t8aasSmJfMsPvStibUVke?=
 =?us-ascii?Q?nTh0AVS32Qik082P78/AKHfc2DndFoh1jHZvSmRXSjPElxKSdZzpC2b2wIDG?=
 =?us-ascii?Q?q6lcg7TsDOlZFuhSDp0zTebdcMZzKBBkdmavlLHPyuKlw3UiBlbQTeiCrp0C?=
 =?us-ascii?Q?tv19g3h3YZHZ5YkZ7DUy3bEHN3JNLO5FD0StXL4ErA80DxLBr+r2QBoEEdmp?=
 =?us-ascii?Q?huBIbUbQS8EwEaAjiDL2cAd4S1U6Q3mOrHuWFMWBpbSqEPemnUAjwCvIbbY3?=
 =?us-ascii?Q?fM6lfbH8ujloI0egJKq5PVELVu/24qJhq0UEcIGPKsHm1CnBjC5MT9jEGTpI?=
 =?us-ascii?Q?pyh3gnmvDDblVt0BNoe4ZSfaHagkB1vgfn9ctSN/QJSO/gwlQ8X+M8XxvJTz?=
 =?us-ascii?Q?YkM2Wdht/q0LjPFfDq0fiHEtXwn+szhNfiQA8ZBMXCVfjXxnfqzDJ+jnZ5g7?=
 =?us-ascii?Q?LmIaFjqN80DZ2z6SLBLFXB8nBHprBgI1T+JSiAMxqW/RTUGe6NRnVLsdRzB1?=
 =?us-ascii?Q?mIN95b4Uw2nBqGbYy5fPvp7OuVLObu7u+2tnFHL8roMHKJz5M+AvREa4sOb0?=
 =?us-ascii?Q?QNiCsOVCyR7gHdue43zmbHKKtU1CpQsUpq2qApfa06j?=
X-Microsoft-Antispam-Message-Info: 41ISRtkLwQMIUNs0RFsF1TGuf7YTGch1gjsWL5rMa2fDFV4UIYdRBBbsEgvsjIxZ1mL7jKkrKy9afYheUWmU5CTdYPixsc2SfJC4wfunG4EOI9hrb7elG0kbRe7nMMLlNLpxG9JL5+GDzVNWKUtd2/dz1ct8gpxTmpDFXiIeknrNuWNMQn27uO4+/C1oyoiqQp6p9T7g6sEDLVqPSVT8eKGAh1/CWuYa5aRjMmtQG/Bxu3ZyH8Nbsb4cv/rczIHsjZvghAEekFnPkSaXun0n10BV9+cQy/H0iE17WGAPJffBqkXHf8i29t/JgLxrXk6Um6F7sMVEoVEEhVM5v11C97orKj992EXquzkPJBGtRco=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4943;6:QJZwMi36R8Mpcz90oVoMwMPN1/K5a6bxyftNjOkZh/vc5RjWlUfa49QVZJArZIfgOiT+nqFL3wouIrC4JnTFgy1ziYhlXDctvXX+anFpaXE+/8jsTB+ZF1+g3IVf+rTq/cDny0APMaTXcFTeoW/5yBjdUTfzndEFT9lWNw8EoHzca9TCPpk2b0HL4C/WnikOKMlIUddBiG3W1B4Weqsgp5IfhuJ06plSR2EgISbDys2UqA5MMDoHDS0nDmbAhNrGo6ZfblEaCaRNkBV9H23KpTwHrYbnAtN+qNyOpJQd328Uo4xAubTK0T3kTQCvaiTeeYyX/w27765h3CaQVL5/KMgCzXnncVcDcLYVgVOXcDj/6q47L/jfmFsflRd+vJNLARNwOJToEcixI4wkeumRPM4KMVQQiFpTXWqh2mEVf/6uGf3/UJnJdl8E2gEisc+HsyjCPYn3Xd0c/aQiwm8ZIg==;5:njvq3EcthYdMAT/Bkda/Zf83TKdOcRvfV/28CyIbKN2/8DVHOnv4fOMHR47mHnmIMwiHaJXn0lqnYoYKJHMCWUCpaDpV1afwqpJL1HjyEv9AXSfXobz9lWDQsEDbiMTHDeaoVgN64m6bhlogFDt7zGofGR9sO76pjA2PAdzIquA=;7:MyLctMuFALfHgpFK8xst/wtvvdFZdkBmLeSluujmqwuxZYeIvpt4QFo22TXaRQIG8NIzkckp77xUCn+hdFsQj4ro5/zPtuGOlhnmpoVXOhKdW70B3CIw+6MYrifgB7O1ursQv/QJLrSKa3dQu7i1uS3NAq4ePoQW0Q+1+Lb0GslJDHbue4JMonftXKYk5JLT5gvF3gFeoz70aMyFb6+IMjfz0JPj9E2uSx2kHqLCbDdsK67nzRcBZSOnBd+fs0tL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 21:01:26.8959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d5d999-f64a-41fa-e564-08d6150513c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Sep 07, 2018 at 03:29:03PM -0500, Rob Herring wrote:
> On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
> > The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
> > back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
> > a /chosen node but that node has no bootargs property or a bootargs
> > property of length zero.
> 
> The Risc-V guys found a similar issue if chosen is missing[1]. I
> started a patch[2] to address that, but then looking at the different
> arches wasn't sure if I'd break something. I don't recall for sure,
> but it may have been MIPS that worried me.
> 
> > This is problematic for the MIPS architecture because we support
> > concatenating arguments from either the DT or the bootloader with those
> > from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
> > gives us no way of knowing whether boot_command_line contains arguments
> > from DT or already contains CONFIG_CMDLINE. This can lead to us
> > concatenating CONFIG_CMDLINE with itself, duplicating command line
> > arguments which can be problematic (eg. for earlycon which will attempt
> > to register the same console twice & warn about it).
> 
> If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
> But I guess part of the problem is MIPS using its own kconfig options.

Yes, that's part of the problem but there's more:

  - We can also take arguments from the bootloader/prom, so it's not
    just DT or CONFIG_CMDLINE as taken into account by
    early_init_dt_scan_chosen(). MIPS has options to concatenate various
    combinations of DT, bootloader & CONFIG_CMDLINE arguments & there's
    no mapping to move all of them to just CONFIG_CMDLINE_EXTEND &
    CONFIG_CMDLINE_OVERRIDE.

  - Some MIPS systems don't use DT, so don't run
    early_init_dt_scan_chosen() at all. Thus the architecture code still
    needs to deal with the bootloader/prom & CONFIG_CMDLINE cases
    anyway. In a perfect world we'd migrate all systems to use DT but in
    this world I don't see that happening until we kill off support for
    some of the older systems, which always seems contentious. Even then
    there'd be a lot of work for some of the remaining systems. I guess
    we could enable DT for these systems & only use it for the command
    line, it just feels like overkill.

> > Move the CONFIG_CMDLINE-related logic to a weak function that
> > architectures can provide their own version of, such that we continue to
> > use the existing logic for architectures where it's suitable but also
> > allow MIPS to override this behaviour such that the architecture code
> > knows when CONFIG_CMDLINE is used.
> 
> More arch specific functions is not what I want. Really, all the
> cmdline manipulating logic doesn't belong in DT code, but it shouldn't
> be in the arch specific code either IMO. Really it should be some
> common kernel function which calls into the DT code to retrieve the DT
> bootargs and that's it. Then you can skip calling that kernel function
> if you really need non-standard handling.

That would make sense.

> Perhaps you should consider filling DT bootargs with the cmdline from
> bootloader. IOW, make the legacy case look like the non-legacy case
> early, and then the kernel doesn't have to deal with both cases later
> on.

That could work, but would force us to use DT universally & is a larger
change than this, which I was hoping to get in 4.19 to fix the
regression described in patch 2 that happened back in 4.16. But if
you're unhappy with this perhaps we just have to live with it a little
longer...

An alternative workaround to this that would contain the regression fix
within arch/mips/ would be to initialize boot_command_line to a single
space character prior to early_init_dt_scan_chosen(), which would
prevent early_init_dt_scan_chosen() from copying CONFIG_CMDLINE there.
That smells much more like a hack to me than this patch though, so I'd
rather not.

Thanks,
    Paul
