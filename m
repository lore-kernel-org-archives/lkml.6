Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA23C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB32A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="JdlgUf2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB32A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeGSVHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:07:01 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:2976
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbeGSVHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R+cwphfMWMr898VLJzxyfTpcdq0AWBddamXfcPKh7M=;
 b=JdlgUf2oaYd11V0K9EpjRD7wS3XbpKSlzpMi93YJxb4Rz3qV1FxW187SUpNeug3CAeZpInEcu20wFhhCaTcdprFa3wIlL+p4z7ewDGTrdgRQm1o5EvyMrroPQeOwx/UD7gN2eGT3SVaodCVWFK5d/wHsHHiqt9wp9BUXV/wcev0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (88.235.165.141) by
 BN7PR07MB4372.namprd07.prod.outlook.com (2603:10b6:406:b5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Thu, 19 Jul 2018 20:22:12 +0000
Date:   Thu, 19 Jul 2018 23:22:00 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nohz: don't kick non-idle CPUs in
 tick_nohz_full_kick_cpu()
Message-ID: <20180719202200.GA17106@yury-thinkpad>
References: <20180712181922.23073-1-ynorov@caviumnetworks.com>
 <20180716153109.GA29270@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716153109.GA29270@lerouge>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [88.235.165.141]
X-ClientProxiedBy: VI1PR08CA0129.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::31) To BN7PR07MB4372.namprd07.prod.outlook.com
 (2603:10b6:406:b5::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e5c96a9-082d-4a1b-eb9f-08d5edb5505b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4372;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;3:zYRrdjIhrcGVLV8HKi4ipDaLls6vNOCmEHHHnLwEwt7PEVoTz7ZPcN3pzl3IOeOSqtr84ZsWgJF+i39IEnv4P/Iy2dQNzpglmH8nlHFD2/od6+R1YyXBijb9RocxbnVWmSZ7qxWXdNn0bfUN65E8zQZoAZVF0ykHtBeQ8g/Ousm3tGPcyIqYXHVgBYIn154cKW3Ms7SVekedOlWEwKac5rkGaGqFg64l5q/k4QJPLD1aIEvmEG2oZpys32pEkkmH;25:PN7Qa51LeFzjFZPdraa2h3kEF44PR/eDXTT0emqTbygO2klRsbbVnCcteAPFsmEZAAoAsHZ859Cz8sFoaUEFzFrGsWcvPbWMJGy+DTbIfPVlY6eFxom2/ROxEZqLsmLWftR5eOTHl4Ona25iw0MTQcLc8qgomgykXZ74EZzI0+2LocxqdW0i333b3cdGiZ3ArhVQc+ORNPLXdiCrCLh4B7rgb7Rz1b8Eu4dslg3N9UsKygvIGNoV7dyGHwBHOaupO0bYs5I6aCh6O6rUmIWl3iqzYlbAfIvhUo3GMCGfod6iRo4GqkcHQWH5VLNNTnUxec2LLnLaVho7Tdo3oDnnIA==;31:7XkYIX6dUQIZAxwWC+beeNGEhT2/6YXBcB1SAQm6UYodYlEOdkqraQSvfSN5tpdUP3+ihYVwPwJIXiwkvcir0xLvFrLJZqlv4CT9ydqIc1yMxeq0xDcAb5SlcSvwDjthFNlVZEQctkLVfBIIjeT1y41n9o5vgrROJy2mZ7CXvVnakXsoTn8LLmeIeKsOkU4YFX5awJkM+MNSUjGytUqrZ9pevAAd374K4yEbFnPeVrc=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4372:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;20:K6cLvkYDe0XrT2QNhh0gwU72uNMddruRg8FHuiXIBwIPmvhoapa2oKXHSYtu9Zbd93LeXWSQxe/0V5TQz5CwpNNsaf1l05XMSrNpNS53eLHu7vHgn5iZ475nPm4rImQB79AT8H0yadZWdvc8GuGpmBWq52gY4Qr/8oHDozvEgLgQpCte+yf8UDJSl1cgGB2sA2pwrvjPoXyuXLNQ7vqj36HxHeEtARSFqcyHsS/Wza1nnpjbNAz5rqw5uPK2Z9uzll0/vuF5TUDiNpb/u74DZA67UFobWxh/EWaQq+mpcp67qRaJZkOfBKsLrdxGCE0bbF0w+sDg18tTYJ5vMXaZZ0Wcre09xHi60XfOOHn4G+RMxrcmDmeBVFEiuXaTgPwq6CJY29taWLGaCEY+nECppPsizlu7rZIg8OTnXIVY3u/29Q9oLFjmgK+c4C1+AX6+p1KYbbR9iygoVM41fV0Eo1xLubDzgEVKKn9PKmBFW51ZAE/iZjn964O/XxY5+xGGvvXq1SxVuU2+riU6txwdtgPO1h3Wl93tL+GVLhGbsm9tOftLBfOeYmG0lzX8h2noXceJWABX39zfdzkQ8sAp0vyb0KlIdzhOPy+LD/UMFQo=
X-Microsoft-Antispam-PRVS: <BN7PR07MB43721FE78CF344837F2A16C0E3520@BN7PR07MB4372.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(158342451672863)(192374486261705)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4372;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4372;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;4:p8sGLUxr4qXHIKKFPHgA0drpFNSQysVLadmepsGu77654HyDb0n9JBNAgBckFrs8pW8R1ywEQgC9BcKw95pOniwPhToL4PkhiGuDy01mjodQtpfiyLZX9PORv6bZJ2WfL+Dt7bcR73U040XoUYA6Cr4OTXukPYZz8nlaJcXbyaKi8QN6FLh9UW8ZTl5dgSMC7zRJXKKQiBRFafn8AOFhXlBUDmEZkr7m0zaFKIMEZMzLnwcbZGvcmk9+ayXkZwHm04fJN47qwFaLoBmECVbckvCpeF6pwruCqGL8+qiEp8Cvr0XL1ndRzI6ymY+lu/ZKYCI7mQDec3BKKcqI208S40kZzn/9EQUe5AdZC40pPMDQVoksDc1jo4Ze79c2cVBeLL8phQmqwTKIsXVYzAaB/Jp7pvNpM179YBaqrptFPic=
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(305945005)(486006)(76506005)(2906002)(956004)(478600001)(23726003)(1076002)(4326008)(316002)(66066001)(54906003)(47776003)(33656002)(16586007)(58126008)(11346002)(966005)(42882007)(6116002)(3846002)(446003)(8936002)(25786009)(5660300001)(7736002)(9686003)(476003)(72206003)(76176011)(6916009)(6306002)(68736007)(186003)(229853002)(33896004)(106356001)(6496006)(52116002)(50466002)(8676002)(53936002)(6666003)(16526019)(26005)(53546011)(386003)(14444005)(55236004)(105586002)(575784001)(97736004)(6246003)(33716001)(81166006)(81156014)(39060400002)(6486002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4372;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4372;23:OOhWCDzZVWldI8CZqqpIse24kQykge1RAn7gOAkgS?=
 =?us-ascii?Q?tEvCaU3TPeaYoQ+lOo5TFTXLRFvZ1VDc7ug1lzROhCQ7NGe8hGV5+L1c5lmc?=
 =?us-ascii?Q?dHyN/t+/70PPbAsV8kdCHk2wgDeGvQLedZikg1phEJ97YjBv5JzF6UE/PmXn?=
 =?us-ascii?Q?32VIB3+/99HxDCGt4tiE3q2fzi0DbNz5XunyUalqkA8d8lGRJDhDGR3/3bDh?=
 =?us-ascii?Q?7aQ5tniI0+DX88NxhSkoVfaIb5418uj5juQD3UXWM7b7TTRfi3g5awtu3xTt?=
 =?us-ascii?Q?aCsAugYZdJ3P9nkSQem6uS1ZwZbHpK89HR95yxF76bUCWgblzx0/TGJS51JK?=
 =?us-ascii?Q?FgtLXidOE2VZ6g1GXlPkG0qf1Xl8B17XEtf88N2R1snT+dLtDHeehr7ShWsB?=
 =?us-ascii?Q?2ExnyXBo4V39X+D+A5D7DlbkWYGQnsrnd/IEW900zH4kAYZ1/6xQg5vslZRB?=
 =?us-ascii?Q?JJ+no/+cw9sHlVcFmhOX5CLNI+K+F+fFq6arItVyHYh5L5E5ChwOSNKHAJbJ?=
 =?us-ascii?Q?MzxKSZ5U06OTCRwl193aPkva3VLbdXYeEXME3GfT6R3BbYRZDS0nA9F+c3cl?=
 =?us-ascii?Q?ufyRFSPFhWJewYWqE3/USyBpA5Qj7AzzQVXb0i6Dzc0MlHgvtMtbv30u8kyZ?=
 =?us-ascii?Q?tBxrgOjTovRRMWMc2f77QagV2gnoaDJOs4yTPmIPPmYyJNad9SdiyeuDOknW?=
 =?us-ascii?Q?x6IIkovEhhacYNwBRbcnD8y+NATa090xB8K+t3sNa6YSoNTomjIH36Eh8TF9?=
 =?us-ascii?Q?xmtFrJIYyhtsH1XyHounxWph9jb+TggNyItcCDFgJjG/xFSWSu77heaOkXFZ?=
 =?us-ascii?Q?3FBcK5yLjIvlyW7P6dho88gugKLq7FRmthxI9qyFi1iBQ/L0XOy5aLB2H1ma?=
 =?us-ascii?Q?zwXivIx7bOVGLAd0YMLRRhr07XNbu0uhrVVUf5XTiy8Id6rnrbtndOC6eCKp?=
 =?us-ascii?Q?ZvAN1LqoLfXl0FS+00vGYArNAgSgPJ+YAcgFHeln4kRF6HDwAGriGbzUMJpN?=
 =?us-ascii?Q?EuI4Elx31jDaHfDZelDDGsl/UbINk3ZNri90+2aSAP6lQfFk0CE/eBpQT+T6?=
 =?us-ascii?Q?h3g9AfbFvkYtT/OUHExf6KUzW3ei9oycjc6WOB2aEVlhZqETgdEoiTs5OQ8j?=
 =?us-ascii?Q?uSHK1F4TiB4/PVAAfOqOZ7UyocTa+lqGEwGT/NiT9FHxZmfkTTzFkUXi8w/b?=
 =?us-ascii?Q?l6MjquazO+dBt5MwQ1c+V9HYh7rwX+pvr3Mi/7Oundjcyqu9rCIBfoAG8wg4?=
 =?us-ascii?Q?gyke1uRDOEbt55ZZqy4N+Fke3siJDooiTwegi4Su0Ug5SKI4CHXw1IpXbIbY?=
 =?us-ascii?Q?I3J5EkZVQpHiwei+Wzw7Ek/LEtEXIQKsUzXWX2Jx/Xssumz3i7VfzBtXwP/x?=
 =?us-ascii?Q?RlxBvSHYvRAc7B9WCBJUYx0b413kW3FcB2l4AHNlUQ9YEq0kY3xEabrFbblD?=
 =?us-ascii?Q?T1PtRvLTKCwTEe62aUum0UxqPxp1hyWf1A02BjmLDL5jPvfScWyE3wN3huap?=
 =?us-ascii?Q?xi2Y4ih1iGMUcpG9ZxWK8EqwgA/jU3z048=3D?=
X-Microsoft-Antispam-Message-Info: BXDFxnKOzGuZvR+cOTCBRRdMalPrWaVzzkwbF/vCe9XrRJ+DfjOLEyKEGme3T4k9rZL3BIt7L0dUvKK885isLXVJS0mfxiFSLMrSxat2YqXbV8nHMj85IAYDHFd72ZymwjinARuuEYKjiFF+1/ig/21L0oiWJufaMtCI9cz3fyb9+M3ZPz8bcSr48xf6b7AsEI99SXSL6P89fqCZe99NrXtUUS0wQYBguPhiaISX9XDSLZjL3fNePa8+kLG1xWzU2qgmfywtWZJw090FP663Ku/CMIri6ogf6KUTUnrozhdoiMHVoAUyF34hhXdta/nVC6c9eV+2tdRzbZ5uNTl6fzUfb7qIAy+++wvOwSS5IMs=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;6:/5ZQSylIikImmiPBJIByK52im4nnhAFvZ5A+q4tliGpgApyfvLyHSIzbATKT4zbuRKrsRD8OqLn9rmLrnyc4LZm2QExEl0+3Tj45NV9/WZFU2AB/mprf7hHlJeo0gBh1I3eu+1phK9oangfBOhIoK87Nm8aEkr4djihj122DJymTdK29F/imvMK9ZqU81wnwItbWWisiATJBNPJpcouokWrVeQWCPKHcrkfMktGky4F7kfJrqsumTntjcAEHgGI6MS7AQrDkQR265uvNcU729Rt9c4Ms7QvSkwusdc2B7I+RFayweCTvjbIWx9nbkCcck54Q5wqqbe7e1CD1L9G52kR4j+IB0ndm0hRvZefudq6uMhhlqTT84lwkQktATFleErcLG5RLYQnaf/2yG/QsJOQtSOOZp+b7oKLrCa1nJ5HQDwiNO8nL8mWKQp/5tg7J2/JJrlJaShfqi5DlLqOrtA==;5:7Kxi4K+vpO3ICWDOAH8BjBIn0rjC8oj4LOJklpC57JJWx9EiJTi8EBJxBPGpbPd4fol4d8z2KEpEuHIswgJQVU7adFaqZ9774VLz53o5dpZXyc9BW1ZKKHHqLo64e5SQAFEmN/8zC9UN/ii79lvoUU3kkVjaRMqn1Mlzhvs8RP8=;24:AZ+6m5d570P8QWnhq4T2ycppFnytsmTPtG8fFhXL8cige2JvLcf7Y9MnD3l/mG/FwQXFHcY90wnbCN2lpVghnool01+acGkamf5PTg8NXho=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;7:fHWqDPz/HthiSVNjHKC0YIGli4Hoy5weRqZS9dSGQLiUXEeT6FPxziQ2Q5Idhz2w+3EZlIKxR9V8HKsjeAzLRRqrmaLRtmcgM0aT3Jlm75GFuITsePpQ2vpUeUh+qi0Q/mp49wsvEM5IlxMnh3HpIk4zGooHpm9DfIp+0qbbM66I3BKer3swGrbVBS+hv51rM2nUmAvh+LJGROf36oD7X/GIg7FZmOesnSO50XnB+fQa0NtbHuKeM61zyKzdMSH5
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 20:22:12.5701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5c96a9-082d-4a1b-eb9f-08d5edb5505b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 05:31:10PM +0200, Frederic Weisbecker wrote:
> External Email
> 
> On Thu, Jul 12, 2018 at 09:19:22PM +0300, Yury Norov wrote:
> > IIUC, tick_nohz_full_kick_cpu() is intended to wakeup idle CPUs
> > that will not be poked by scheduler because they are actually
> > nohz_full.
> 
> Not exactly. It is intended to trigger an interrupt on a nohz_full
> CPU that may be running in userspace without any tick. The irq_exit()
> code let us reprogramm the tick with the latest dependency updates.
> 
> >
> > But in fact this function kicks all CPUs listed in tick_nohz_full_mask,
> > namely:
> >  - idle CPUs;
> >  - CPUs runnung normal tasks;
> >  - CPUs running isolated tasks [1];
> >
> > For normal tasks it introduces unneeded latency, and for isolated tasks
> > it's fatal because isolation gets broken and task receives SIGKILL.
> 
> So this patch applies on Chris series right?

This patch may be applied on master. That's why I sent it to you.

> For now there is no such
> distinction between normal and isolated tasks. Any task running in a
> nohz_full CPU is considered to be isolated.
>
> > The patch below makes tick_nohz_full_kick_cpu() kicking only idle CPUs.
> > Non-idle nohz_full CPUs will observe changed system settings just like
> > non-idle normal (i.e. not nohz_full) CPUs, at next reschedule.
> 
> That's not exactly what we want. In fact when a task runs in a nohz_full CPU,
> it may not meet any reschedule interrupt for a long while. This is why we have
> tick_nohz_full_kick_cpu() in order to force a nohz_full CPU to see the latest
> changes.

OK, got it.

So if my understanding correct, there is 'soft isolation' which is
nohz_full, and 'hard isolation' which is Chris' task_isonation feature. For
soft isolation, the desirable behavior is to receive interrupts generated 
by tick_nohz_full_kick_cpu(), and for hard isolation it's obviously not
desirable because it kills application. 

The patch below adds check against task isolation in tick_nohz_full_kick_cpu().
It is on top of Chris' series. Is it OK from nohz point of view?

---

While here. I just wonder, on my system IRQs are sent to nohz_full CPUs
at every incoming ssh connection. The trace is like this:
[  206.835533] Call trace:
[  206.848411] [<ffff00000889f984>] dump_stack+0x84/0xa8
[  206.853455] [<ffff0000081ea308>] _task_isolation_remote+0x130/0x140
[  206.859714] [<ffff0000081bf5ec>] irq_work_queue_on+0xcc/0xfc
[  206.865365] [<ffff0000081478ac>] tick_nohz_full_kick_cpu+0x88/0x94
[  206.871536] [<ffff000008147930>] tick_nohz_dep_set_all+0x78/0xa8
[  206.877533] [<ffff000008147b58>] tick_nohz_dep_set_signal+0x28/0x34
[  206.883792] [<ffff0000081421fc>] set_process_cpu_timer+0xd0/0x128
[  206.889876] [<ffff0000081422ac>] update_rlimit_cpu+0x58/0x7c
[  206.895528] [<ffff0000083aa3d0>] selinux_bprm_committing_creds+0x180/0x1fc
[  206.902394] [<ffff00000839e394>] security_bprm_committing_creds+0x40/0x5c
[  206.909173] [<ffff00000828c4a0>] install_exec_creds+0x20/0x6c
[  206.914911] [<ffff0000082e15b0>] load_elf_binary+0x368/0xbb8
[  206.920561] [<ffff00000828d09c>] search_binary_handler+0xb8/0x224
[  206.926645] [<ffff00000828d99c>] do_execveat_common+0x44c/0x5f0
[  206.932555] [<ffff00000828db78>] do_execve+0x38/0x44
[  206.937510] [<ffff00000828dd74>] SyS_execve+0x34/0x44

I suspect that scp, ssh tunneling and similar network activities will source 
ticks on nohz_full CPUs as well. On high-loaded server it may generate
significant interrupt traffic on nohz_full CPUs. Is it desirable behavior?

---
Yury

From 9be3c9996c06319a8070ac182291d08acfdc588d Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Tue, 17 Jul 2018 12:40:49 +0300
Subject: [PATCH] task_isolation: don't kick isolated CPUs with
 tick_nohz_full_kick_cpu()
To: Chris Metcalf <cmetcalf@mellanox.com>, 
        Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Goutham, Sunil" <Sunil.Goutham@cavium.com>,
	linux-kernel@vger.kernel.org

On top of Chris Metcalf series:
https://lkml.org/lkml/2017/11/3/589

tick_nohz_full_kick_cpu() currently interrupts CPUs that may run isolated
task. It's not desirable because that kick will kill isolated application.

The patch below adds check against task isolation in
tick_nohz_full_kick_cpu() to prevent breaking the isolation.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/isolation.h | 7 +++++++
 kernel/isolation.c        | 6 ------
 kernel/time/tick-sched.c  | 5 +++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/isolation.h b/include/linux/isolation.h
index b7f0a9085b13..fad606cdcd5e 100644
--- a/include/linux/isolation.h
+++ b/include/linux/isolation.h
@@ -158,6 +158,12 @@ static inline void task_isolation_user_exit(void)
 #endif
 }
 
+static inline bool is_isolation_cpu(int cpu)
+{
+	return task_isolation_map != NULL &&
+		cpumask_test_cpu(cpu, task_isolation_map);
+}
+
 #else /* !CONFIG_TASK_ISOLATION */
 static inline int task_isolation_request(unsigned int flags) { return -EINVAL; }
 static inline void task_isolation_start(void) { }
@@ -172,6 +178,7 @@ static inline void task_isolation_remote_cpumask_interrupt(
 	const struct cpumask *mask, const char *fmt, ...) { }
 static inline void task_isolation_signal(struct task_struct *task) { }
 static inline void task_isolation_user_exit(void) { }
+static inline bool is_isolation_cpu(int cpu) { return 0; }
 #endif
 
 #endif /* _LINUX_ISOLATION_H */
diff --git a/kernel/isolation.c b/kernel/isolation.c
index 1e39a1493e76..05db247924ef 100644
--- a/kernel/isolation.c
+++ b/kernel/isolation.c
@@ -41,12 +41,6 @@ static int __init task_isolation_init(void)
 }
 core_initcall(task_isolation_init)
 
-static inline bool is_isolation_cpu(int cpu)
-{
-	return task_isolation_map != NULL &&
-		cpumask_test_cpu(cpu, task_isolation_map);
-}
-
 /* Enable stack backtraces of any interrupts of task_isolation cores. */
 static bool task_isolation_debug;
 static int __init task_isolation_debug_func(char *str)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c026145eba2f..91928a6afd81 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -23,6 +23,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/nohz.h>
+#include <linux/isolation.h>
 #include <linux/module.h>
 #include <linux/irq_work.h>
 #include <linux/posix-timers.h>
@@ -242,12 +243,12 @@ static void tick_nohz_full_kick(void)
 }
 
 /*
- * Kick the CPU if it's full dynticks in order to force it to
+ * Kick the CPU if it's full dynticks and not isolated in order to force it to
  * re-evaluate its dependency on the tick and restart it if necessary.
  */
 void tick_nohz_full_kick_cpu(int cpu)
 {
-	if (!tick_nohz_full_cpu(cpu))
+	if (!tick_nohz_full_cpu(cpu) || is_isolation_cpu(cpu))
 		return;
 
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
-- 
2.17.1

