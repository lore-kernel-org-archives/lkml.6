Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA6C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B0820842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="xHH9/Yvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B0820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeG3Eqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:46:52 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:31824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeG3Eqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQHAGk0Dl72HK4/Cati9fI6MnTATcPa0GmwVnMKDPKc=;
 b=xHH9/YvzEB3GNV8nlqVGRMN6UDk8hqIROMGvL9mFL2W6web2EkERmKOyo6VF4clmXeGWtjVIFGmO8REzWzNjl1WVA7OqVU8w4+wq/MfZC/dqyboboQpeaQO+rtanOyieaWeKZLMNutY7yBAOUZaMdFTzKjIQZfgH8mUxxaTLdzk=
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Mon, 30 Jul
 2018 03:13:55 +0000
Date:   Mon, 30 Jul 2018 11:11:33 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Matthew Leon <matthewleon@linux.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180730111133.0b4e8b2d@xhacker.debian>
In-Reply-To: <01010164e92bcc1a-c3ac69eb-f6e5-4420-ac87-de1a0ffd0ac5-000000@us-west-2.amazonses.com>
References: <20180730104228.28b58bd0@xhacker.debian>
        <20180730104636.1a3e6c81@xhacker.debian>
        <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
        <20180730105954.6c365a7b@xhacker.debian>
        <01010164e92bcc1a-c3ac69eb-f6e5-4420-ac87-de1a0ffd0ac5-000000@us-west-2.amazonses.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::27) To SN1PR0301MB1582.namprd03.prod.outlook.com
 (2a01:111:e400:5232::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b35a8809-0ef5-4597-aa8a-08d5f5ca7ce5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1582;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;3:vgGj1m1JJHYaWYmFizBrimTjdSrspHvHBzEDiNluWcNNc6z9Thtl4FAt4t+3qkESYThnzg4VY/AudNUx+ZXLKrx+zZZ2HqQ7FS553EGITqcKgVLOJzknFqDHHX1m653uHglSqW/rnPJQ8dh1o4oYJF3i2Z/cxHFYg4QyTUWeR3JQ4VtsfuJPvM4W9TWCoU+G0upXApx/vhXKJ2EB3Rh91xSdUIetbVK4Nrj33J0TSx0N5YzvRVZVHlcrMKGnHHHG;25:J8QfOFujYNC+UWo2Nmql0aNPC6l0NwB/oT6eMytwzMpNUaTtTDuYMSnHfPylFipY16g8uYyUsCuQQF9NlHtiaj3yvhbo+A+5tsnnXoJau8pd96GPAv6Zq0jtkPw17gm5l/+xAZGg122AyaWzn2MR8jC9hD09R9atXkjQmAfISNyhuwXmhDq3fXciv3bnDqC14mNBrgApN3uB0MZENdNBZmUgnV+2QiUBmgBnRjWdPQXT0iwtsaNA2xYZn0JK1akdEWDNIq1kcMRtvOeCGRMncd8QnJnNJucdV9Su/44qpuvJ0YuOLmPG5TcF2nrZmYecKBL5o5AJ2qYz0Yas9x+MkA==;31:I7KsxzDBLdB0qgUnOMbmxAaT3YFYmpMRDi4nfQddh3W1n+BOAL5sXyPEiV2OtI8VBYmpRbG9m07jIVC/WMx0sudUkMhzXebd8fth2cDMr86d0KNWbghQLOv5MOzWvL6llMEilR7yU5kGuBg9CqU82MfESzsjCzYaHnYI5lD4uGEgit/qAKrfqC1dFjKEdwzBWwv3+vX2c56ahEt71CtuPtF/sgjn1R4nepDYpfKT+8k=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1582:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;20:4SQROwZ27Do7zp1auc4ed4sbUkKKcZZnCdqxIkyz1dW/YosPrp+XvmgaKSU+bNpjbQu0Hbavg+DK53HnHzemyAAnuGMRXhm0crT6gkgRA+wOvujAV0AhkEMQ1n3LNaUUBpLP4aCihmJvF1gRFgUuWL+95gZDe8MSqT/ObDnz/jaVTmlQl/6bEN/qyrQEWEn5jUa7tqaFe3x3UD1GsynubnliC2iELMztUx8hE+ezXybopE3ju2Qv8xRESw6VPoN21qrWmmdvZXwZ+FWFzeFoYYGQBnoJlaTvzsJyIuv2zQg/g2QVio76/rRf72KZ/Go3jtCH+GmzuWIXjSfS+HCyrglbnKZ+7pJtsS0HZV5PqSim8zoO2nR41RA5Flo/C6sjwLM/z9VM20mjo6ugWiDyc+TNhf8yxPfXD8IqZu7gushSMFwgkubzzQSSiyNaxWIyiwoY63N2UA7b3jyTefoUo1+skGu3ZgzLnPP0QFMNX1xcclNFaRRLX69guuXLZaN7;4:wno4g9ZEXhnEF+YdwLyHtQoi/I21mbW1kdRhg0E69HfRxDeqE5X1WENh2qaWmMYLFfy+NNRWBmxzqO3b4UPWJQcuviVh9YykhP4eaGz5z6O7lkI5bs81nX+tKm9tePv8FtonUgZNGPNbL9+Nvy/eGDDvTp+bwqYbIME1HL5UFrrnrGeAaGApgfJY7oDQFuwpthdkmXDDBc3jui1ByVxyU7Ayg2yidliM+RO/1B37dRakAK3kl7a9qjn8/50jE/hh0C5aHFVdG3Xm7PSEJfilfQ==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1582D8FE0171C2A778A20708ED2F0@SN1PR0301MB1582.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR0301MB1582;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1582;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39850400004)(199004)(189003)(33896004)(7736002)(476003)(50466002)(52116002)(7696005)(305945005)(93886005)(86362001)(9686003)(4326008)(55016002)(54906003)(53936002)(76176011)(81156014)(81166006)(6246003)(6506007)(386003)(486006)(97736004)(8676002)(6916009)(446003)(11346002)(23726003)(72206003)(1076002)(229853002)(478600001)(16526019)(8936002)(68736007)(186003)(2906002)(6666003)(47776003)(956004)(50226002)(106356001)(26005)(230700001)(105586002)(6116002)(3846002)(25786009)(5660300001)(66066001)(316002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1582;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1582;23:oAaEB98p4W4/2NjzUYBmGZ5/StJfm0XoIQ2cpLy?=
 =?us-ascii?Q?YyxAFq60iCse/rbQ11jRC8KKGDKsAldW2sIXLdt3kXCikUxBpCF464U11Lm0?=
 =?us-ascii?Q?zklDF+Ih+UEA1gon8Z74WGo7dQAhUGPu/NELNB1FhUWTNBGU8hCyUJMtd4fT?=
 =?us-ascii?Q?1nMtOvv2LVbnERtXsf8ZJTeM/CYWgEC6tcGyXTewlxynpkFgc1wTowIrkrXI?=
 =?us-ascii?Q?G3K18KwpoizLzN/YMA2H6AtlC/srp0tLAxRdZEVvXVU5Gh6W2zWReTgtfEDS?=
 =?us-ascii?Q?pkJzg4gSjRLx96XSBQcH19pAWR+YPjmKcGrjebD/1ZLMP167OmDQqd41Dyhe?=
 =?us-ascii?Q?w9eYfDyxPzGRQvmx4niPUYHQR/zhYDfZAkiOV1htLUOKbcPy80XLX6CEOvBO?=
 =?us-ascii?Q?RzQwFMuDv9aq/4I3is7CVMPDmNX5RRAGbMAXCKu4ekju8UC/Ja5mxmPcQBE3?=
 =?us-ascii?Q?6l7YwIMrrzx0FCaUPDei+/Z4+SXz2YYFcn5OwDXrwawPfS41batp0uPj6i9d?=
 =?us-ascii?Q?nP6kThWvNYVKevsbYJqmukwk485KccUhn+SHYeKla0mm90Kdy8rPQrDUU8Tm?=
 =?us-ascii?Q?yphIrAZzqx7NRt1pqWltGDmFNuWay08hgNTssYXv4NIqTUXtyo2iDGgwVb0M?=
 =?us-ascii?Q?jLEvUgodF8Op1xWx/fL4wnOQ/eVd62OLPUewKkUt4XUdeiD6nsq8PMurY9y3?=
 =?us-ascii?Q?YPFPDzxkAKgy4+tP1myE9ACRSEBAx+6JNhyCOx+FrjuA+SDu+tLeA1Ah7PxG?=
 =?us-ascii?Q?CcswRzJ4fIM+1zqFNVoX7IdaTuyzO03bcq6iPGyXROYNT1G8+XsBp6LhgKxh?=
 =?us-ascii?Q?jlNFZB5KlWQspTgPzfrV/jTJJuyBZM9q/DYsQb4tQlAYvk/5BBWyp/SELcb/?=
 =?us-ascii?Q?aFV64XvE4G8XdrWGjd/s2K7BShHnWtibaJBnFOC63hSjH6INccK12+qo0G81?=
 =?us-ascii?Q?42bFgBRvAWUEuPX5xb9TucHnVlA8LRNa68msEnXDOaBnrRn/IXph3FN8/AgD?=
 =?us-ascii?Q?FAGjjY6T21x3raPD/ERAUg52EQnkYC/aMpRG6UaL4LRkFSGMUnQ00KdIAekg?=
 =?us-ascii?Q?DPwTV5i9sv06MEjcGClgchUW4X/OSC8qQyf+eeemEIpISoGB7Megft7tLw9E?=
 =?us-ascii?Q?0rNvtUdJ+M34AXJ7thyRnpyWb06EFfKiT5qwaAsuoSjd9+Z5rX7Xao70SctZ?=
 =?us-ascii?Q?0kvXq9gR/JQWoeUFE3WbDbUK9S5jZEYcPj2MtnajleF+7fnngt1dSRfOoS+N?=
 =?us-ascii?Q?V4AiaRy2CwZ2bMcyyvQBmvQOKwNNVUPsOSU60VYyFWKxw1H9vzeKZNYIWZ3r?=
 =?us-ascii?Q?ePTyxcmPVQzO+xbrUI9uNPGw=3D?=
X-Microsoft-Antispam-Message-Info: /Dud72KdF1ztKZSnu95Cj/r45SwIO7T0uwD51TqJECJs+Gxt/i8gFEkbZ9DED55gXSIoIlDPHK2GW/U0y7f+PMhzhGRi2fhRCcEHgqqRd5bpyT1tdffUjyFwNGpVY6qM53jU1ZtAWreWY1UTPDcO0+RPd6CqbqhCOWtLwzND31tCkO1U1w+/oL5XWmZxJkDdVE9qk1T88XhuPcXnvWHPBiHyukphQ/kQQ5ypLAcOvrN3LLukpmg4vegr/wJGxmQgBoUrt8GNXocmF7SCey0+hDb7GYqpEp+BYiQ+M92m+HaQHCD0WpJ9Vr7NawjoXGRZNGyPSItodbQY8rbnV0RuH/9UZTNnu+KPGGeMu/2SxLM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;6:nkpI3hG9uyErdsrsLQiCZ0f1zJVETI7BMCVBpgCoSmKGcXR/Lo3okppzVCu0qJP09iHf8SPUwS61rXGChLXznHrFay1xINDi9qxvU3xGmYp3C+ApE4FRVNzSxIcv1+jPIvIAAx45ATpOTK2Ys9kUmk0zsHby/9/MJ453eQ2K/aJnJ1t9AVHZL8cARn7IxC2KtCCTp6/5mVVmZ8d5YNGMjVKtnHiqDiNOVdLZKUNZTPGbAftVFdF5SU15n6464XnEFlKwk9gbPevZvnKXcY8xyV8DoQYgYhKMilOuo+6J8ZoMhn1itWjS/57MadY9ueMckY/wdMlsJGSaxCZP4ZrlGxffchSgyOTGQ8CcRK1/PdNaTHImHmqelvOnTGfQfXqctW2FgTt6URjpg5kEgo+ZCMzGTIHGBCBqGCZDqcaoyQER69P15Z04mnaaPKlEwJ/UKcgAjyGvIj/407AooPgnUQ==;5:Nn3T9hNcOaJ6yqno5ouEoIxSEE8iwKudXixSClNDZHbWHipk7ua4o/zlok7YUG6McdBoFxiYDwWEZ/YqecEZ0LGZ9twct5jcl/8RFGcZXafTWEHDFh9lIPXA/vr/fKl1k7VqRvL8j8lqAxubqpNn38ETd/Tmw8HvOudDESCG+hs=;7:SLw04jGzx8oD3JG2tOpJwUyKSBSVI+PgyZXxMbsqPet7r8+bU3ZbX54fiyyRWOfNHe3H7LPXEz+sQKqdUrQcxu3btwWGC4kmUZ2FueAAQegzX9L64EID4WweRWWW6G1QNXUa9FEnEamIakunjiCRpSKnbAmBe3BYlx8t2n6G8skZFsYgo3irwTgVt23KbqHxkfCXWEJSGSOwsTqhXxGuP06nBYi1eYjCX7gvObwr8VqKy22wMU4Unq2wfXb1VwI1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 03:13:55.4167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35a8809-0ef5-4597-aa8a-08d5f5ca7ce5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 03:11:59 +0000
Matthew Leon <matthewleon@linux.com> wrote:

>  >> Hey Jisheng,  
> 
> >Hi,  
> 
> >>  
> 
> >In LKML, we'd better not top post.  
> 
> Noted. My apologies.
> 
> >> Shouldn't we be splitting until all DMA blocks are less than 128M  
> boundary?
> >> I am a noob, but I think we should be prepared for boundaries that when
> >> split in two, will still be greater than 128M. Feel free to disagree but
> >> please explain why I may be wrong. Thank-you.  
> 
> >the limitation is "DMA addr can't span 128MB boundary" rather than "must be
> >less than 128MB", they are different.  
> 
> >And the max transfer size of one DMA desc is 64KB.  
> 
> >thanks  
> 
> I have misspoken. What if the DMA transfer size is 1024M? If we split in
> two, then we have 2 transfers, each of which span 512M. So wouldn't we need
> to split again to have 4 transfers, each of which span 128M?
> 

the max transfer size of each desc is 64KB, how could it be 1024MB?
