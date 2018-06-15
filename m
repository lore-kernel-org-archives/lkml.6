Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4068220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="ngKRGX5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4068220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbeFOWGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:06:24 -0400
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:37568
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756592AbeFOWGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD1gBeiBhsldnOqv5TH19mhL5njzy2jV6c5UDG7l1mM=;
 b=ngKRGX5URswhi6uPHtqDjjpn4opP+s1bWbPs4SB6yWGBPHMAEEDUgWu7hkQT4JZFNMOPq80trX/9tSqyKBQEbncaJCnznZbFD6TAYtHMO968gKOY4S3EEF69yt/4xcCARVy1UE/KoZUrdmRjo9EPfk95tp94VjFe1YwjTcb/TV4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (88.247.2.85) by
 DM6PR07MB4377.namprd07.prod.outlook.com (2603:10b6:5:bf::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Fri, 15 Jun 2018 22:06:19 +0000
Date:   Sat, 16 Jun 2018 01:06:10 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v2 4/5] Input: gpio-keys - Switch to bitmap_zalloc()
Message-ID: <20180615220610.GB371@yury-thinkpad>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
 <20180615132017.23889-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615132017.23889-5-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [88.247.2.85]
X-ClientProxiedBy: AM0PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::42) To DM6PR07MB4377.namprd07.prod.outlook.com
 (2603:10b6:5:bf::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7684741-1b9a-4692-fc3a-08d5d30c392e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4377;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;3:U9RHBI8LnGDnTa2HzOdoGDSOvxSdbGsisaZ48IXb9vTBbU4m9XlAAoORFBXUXvvtsh90eCBS3k4gUzaS0P4ncldZdqEWkPCY1DFOl1t4wlm70fPh7Qp0+BxLcgnXuYrPVih2THHCJiY3S0NU/LtnpJAKyuXEHU6vMe1ag3HRiG6AO+YkTNC3WRxPSua5dbA8jEQ8NhfGxWTZ6S0DOId05Lmx/L0ZxhYuRr5f/zij5xeMk1T1yv3wFS93NefMeggc;25:y7ExUZfkTT5teAbF/AErJE2L8SyH+He9lriM7JdI+lN3kQevWFh+CoDPwKFcd8ded3Lr8tqSMf49hdJQN9rz+hNqYyPCubOGlpEOr2A5x3YqXxVvF2VuQT3hirU/QNdC1GYj69iDOAa50Et72wZBdl+P/xLOdzcZ1nCUh4cpqNH298HKuVtjybY9mhhCw0Yk/zS+mutDKOi9SmxkIER3CdAmp1+3Uf/QXoJ/3Ay+Ygl+yVqtrPMYhMN2xleCUWmuIuM4YDwt2/EOOgLxgj4WajCP2LAEgEIL3acVPKDrDLryn+VRRRL5/Hu+UVUYjIgSBcjRz6vVVBlewaIFIwK9xw==;31:yrcJJsSmqZK6My7k8FgmkZL6mFX3iDXdgWcDQJjKKo5kDU5l4CaibtpAP9AanxhWiUmOEYqou1zrJo6Qel/e9jArMNLH+a1oIVyrsUn1HPvDdiWGng8UN5k8ijeDfc0dvakpeqm+4JZAa8nXSysr7lXFKxCmpnpClrJkqZoIo3b/lZjCQvRE0tY4SdYYRa/QAuuaLgeyQqXNzYGIKMS0DnynlWwH7UwU9H2m2hBHpaU=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4377:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;20:frHoeYaWGA9ZrG1bYE/Xdk2GASGpxtIGc0VSwxtKyO1lpXhQ3t5RGagGoYKQNzaKMJm9nH/QoLPsg4/sOKQ7nb9qBkDFjtaDcV13LRFOXj9nOk8mohlMkSAtqiLQhCZW7ra15SjqkbSLNmDMipQhF44qDmQ3PrngnOxjnJjfeKzudhmPkogKj+plCmN5vU7avZQG5GVsWsbDzyn1hmWJXwGbnjSw1QSsVJDjRAEMAB/tA4KJuX4DOwHQi9GiL3QEmjb1HPfikRtkz/xsBQ0xvV9qK0klo1eQnLB2q7BTGfciz0UNw1G7AnJdzoOC4lpFl+yj2khOEvxVEiZtiPknFRcas/khYnAU7u4d9S5Q6zw/XM6/AQTTcU1X+ppDMRQ9ddJ5KkwcmuU8cKTqjB2X0+7hwjokBWN2pR5tdvIj3AOmkoH1QtsrjM7kh7vyY5tqBE4Rs2LdoXUWiuDpV59sV4MZYbV562CZc/K0L34nUaEGk9bHW8p89X5AOPFsl8lovkdf0F2Rnj5PBoPnLmksvGi8PNhoLJDHBj9+2hDDMB1ZyNxEE8bgpB+Ydzw4l171wTqybKCqF7qHMCy/AXvR0Vli6Etxka3XPnQUjuM8ylU=
X-Microsoft-Antispam-PRVS: <DM6PR07MB437797E28EC7E976FE3D250AE37C0@DM6PR07MB4377.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4377;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4377;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;4:IGQ0OK7t26vpmL3w3XJoqN+PI4iMd9lGZd51WSb7e1qFkiXwaM7UieJ3FAN0uGppay3cJgeg6PJ4/oK/o4+CI5yUX7LEOhFIm28h6BVzHYaaS/kMS0Q+DSAx7u9kDge8BVslbxgMoue/1V3UUPU0ytqeeIpO/9ksKH7bdAyDn3mZ4gd/c4F6B7Gl81BTzrhp7eTEhZAe15MFrpyiQegBZ7vKKAo/0AdQrVN/5h2gj5/A8zNEdEd0zM00IrYH8s6PTZlr8tw0QWm+Q712bPXDzCrIH4H9QuwrI/ynTmxBC6NjSweMBVqHzVb5C6H5eAOOLjaFi3HBADNYk07RphMJBg8rdBVHIUekZUURYJUSinI=
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39380400002)(346002)(376002)(39860400002)(366004)(199004)(189003)(5660300001)(11346002)(446003)(476003)(956004)(2906002)(229853002)(7416002)(68736007)(6916009)(6666003)(7736002)(6496006)(50466002)(305945005)(6486002)(76176011)(486006)(97736004)(33716001)(52116002)(106356001)(55236004)(59450400001)(8936002)(66066001)(42882007)(6116002)(386003)(105586002)(23726003)(1076002)(186003)(26005)(81166006)(33896004)(81156014)(33656002)(76506005)(72206003)(3846002)(47776003)(54906003)(316002)(9686003)(16586007)(53936002)(6246003)(58126008)(16526019)(4326008)(39060400002)(25786009)(8676002)(478600001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4377;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4377;23:sO6m9iiqpfZe/5OstHc0IUJEIXpQoIs/8LDHDeaIg?=
 =?us-ascii?Q?4Lk0bjfR2oLxeYakTirDCoMz5QSj6fs8/DPlroo5Mw87QzVaMtVMGSFbLb6q?=
 =?us-ascii?Q?/w6z1gooI3R1z2wwMqD/f+d9/NfWSPLi1rKSWDd3xes82krRLVCYz9YuZrjW?=
 =?us-ascii?Q?SBp+1ZDwDIlf3Sql8/G3klxHWMIuaLlNicaOU97fNT7FQd1aHYO37WIw8gdo?=
 =?us-ascii?Q?bz3KxL9o2yjLyLUFaWUdHyvBNiC+xHrL1B38FFZAnEtVt4xJDf5Ag9sOX/cB?=
 =?us-ascii?Q?AX0Lhyzme15mcijNJTo0he98jeO0IKXiyF5H92mx4KadpVRX2tDAC0v3CmFs?=
 =?us-ascii?Q?hos4+IOUfCqijONXZ5Z6yVIY0SCw5S6VVGwXtLSJ3SdwIie3eLTiZKKlqr9J?=
 =?us-ascii?Q?z0HEeCECNEwWyMm0xdO5vljyaacIHiVzJkKHx9MR7gvaird2DVhAbq4G/5Td?=
 =?us-ascii?Q?hguyFkz9sXL9p/ksjqkYeGeLwii7WshTdinwqaoMclp0tgcKDGwgs70Yt543?=
 =?us-ascii?Q?CiesqDxlRn1UJ3jxq1Rqpo3+Xibhm10uTVX15UgJfU6Ntne7VVWwYYYNTUu4?=
 =?us-ascii?Q?+XwDbQ7q7HUIa8W+/Vqjj0ITnt26iqzvYWdWDn33SfUCPXFuupklHjOb95EQ?=
 =?us-ascii?Q?bpDP2s4VA0HY9X/aTE62lVSurz0nPsmBtpHOAktB11O2vueVKwqSSnCs6Z1z?=
 =?us-ascii?Q?Pl/XPzq4RriEc357vBO14Hlo7mA67a0tQ7zwIBR0IxxQd9OmTcYTLnTW9mJq?=
 =?us-ascii?Q?CCOiIReWNJDuYZel4gFA30KcZtUrbnSEm+dznFKla20N0kLj9C2gfzV5Ae6w?=
 =?us-ascii?Q?OmxruiacSqkLIJAThsyVX8z7OMthFLR2TAOg/rjSrt6AAs3jc63nw05wXBfH?=
 =?us-ascii?Q?kcS3QEhcp1dGnAoktzRyTGAOHSCN8L0irHBTi4wpk8LzhKoxWEzlMrZ0BG91?=
 =?us-ascii?Q?EsEeFIitMxZnYgDcA4y9ElOCb18aizmNk9wLXi1pP6k45JJ3CLPAhJs89ZLV?=
 =?us-ascii?Q?/IjiMUh5E+YVK59mbMuTsEFZciJIkgnxxclxokRsrOCS42ehEY5YSIr0FjnS?=
 =?us-ascii?Q?xbTGH77xcuyTmAgxjcbBsKlDgd09ZxhFkjztdCdihHnPICK2hFFeqrU5AUbL?=
 =?us-ascii?Q?HKJc29FrsAHXSXm7iCi+AASAvXsoWZWlN4Z4zJ9ljkWGowDxdTDMK5g9AbVX?=
 =?us-ascii?Q?uyEIXLQpJI6qujknzNv47YqLlqF8s78IaQEcEUnePU2GbPQlReLf560a6Q/7?=
 =?us-ascii?Q?mgmdouoEhxj8mqoTizy6qSA6PKbJY1VO7N7QLVB1saoEj21VV3TU7svJ9j6j?=
 =?us-ascii?Q?mi8hma6V07WH1uxH4PhUccKmOnCSlZlmpJnO34ybk+VvVn5BHA5vx7cmu531?=
 =?us-ascii?Q?d2w+Vz9ww3rbcnYxyAW9KmmUnY/q1b7isiyEihxolxvB83e/nhV33pZykOgl?=
 =?us-ascii?Q?Ypeor1c+l/WRPi87pnPmF/28Kik73mQeUB0exbPjA+iwdDr3HNF?=
X-Microsoft-Antispam-Message-Info: moHFr8p39Dv63+HSmI6XVwvAi55gw9pIB3uZ64czB/YiybYPYMMdLndtqSxDID6ZYKHAVKcF+yb7UWCPAgXkJ1LkfpcBddVJXpyuqB3TxIXB4TnAo1Qad+M7xrrX/YyKNnkDv3jOKucQmhgr7OFCIuugdPF20JhxGTPID8CBb7FwizpGZ7w3wtqIccfTSshp
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;6:a1W2JEbucH9G9gfCud3/T/Xq5y03kIIxA8LejejEGn6cVMZLJsJOXX/FDzDuXoAUN6MiUCW16ZwCbVhetOLyW9Bsif6/PwdSXYpaplxx8vA4Af7lyDObxC5SEtsokR7u/sx85OAWUa6HkP+zeUsIcxtaqWvCYdKl3Ck8q8jSu3rcYo38L2LyuSI9kGmpl6swtbtCi/iIQL0pMbz71We8spyw9zSeBsI2+g3dcwM1AG7s4tzeO6Ky7y4JOamom5zaP2+TzolQaF1u8YEJoVZLj8hyCy6qTeI+Y+0fTuzE3EYzLOa4QadQTmKG2eBnlXZuvDx/izI2YqAC4yeGONpvI6gYVU539d06O+jpEQwIg2COpmgKmO+wPMuB6OvVcWwp1CwvrTU+dhKtGBOYlCfJRBYt0UQIgFrrVEV4zWrY7+kCu1ffLrIQ0eUnLR6lCtAy1hGEYS1R+OBquu05KaY5Eg==;5:i7nDHaGsi09FDfn/7jwONvV/CyTtKjZlNpcXLA4rTIFwSln0JDDYP3vtOuQUcqkd1+0rDhZ3MYKXqBy+aI3LOaYmFykP67koGjmevyUF+ObmAt0aiLC/OcP2X21igyzgr4A+VxTknELv0pCEqec+bppJxX7lXVCXDEl4nVEJeJ4=;24:Yw15x/JFiQiTv+mBmip0MCm64ICvVo+JZgaiFiYYwM2zl1IfhKD8blwnYBAoIaTpcjFTpFXOdmwQYTNX2kQssJwC4WOakOcejHJyJIwmMsc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4377;7:B5hcKgoh0scuvWZ7R0g9E8GypB6XyZvMJfIdEUE2gzno4X2fdvUImxzjBDqxZgpnp+AwgSC+Rp9AjipG/yrfi0aVCF18zS+/gWoal9qG9ZOkQeMKOuEHhozJCOYX/823cPs/rDmTqIp4caEmUK+U/tVAnv4CL7IU0RS45jgH+fFkLhabPyrw3dhGpGl+iERRnvIl2ip168VUxxpT0bHrUGfE7EbJ8po6D495loZWtviss+EzYHqj/VraA5ySjmID
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 22:06:19.0554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7684741-1b9a-4692-fc3a-08d5d30c392e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4377
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 04:20:16PM +0300, Andy Shevchenko wrote:
> External Email
> 
> Switch to bitmap_zalloc() to show clearly what we are allocating.
> Besides that it returns pointer of bitmap type instead of opaque void *.

Nit. There's no special type for bitmaps, bitmap_zalloc() returns long *.
Is it less opaque than void *, not sure.
 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/input/keyboard/gpio_keys.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 052e37675086..492a971b95b5 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -196,7 +196,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
>         ssize_t ret;
>         int i;
> 
> -       bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
> +       bits = bitmap_zalloc(n_events, GFP_KERNEL);
>         if (!bits)
>                 return -ENOMEM;
> 
> @@ -216,7 +216,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
>         buf[ret++] = '\n';
>         buf[ret] = '\0';
> 
> -       kfree(bits);
> +       bitmap_free(bits);
> 
>         return ret;
>  }
> @@ -240,7 +240,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>         ssize_t error;
>         int i;
> 
> -       bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
> +       bits = bitmap_zalloc(n_events, GFP_KERNEL);
>         if (!bits)
>                 return -ENOMEM;
> 
> @@ -284,7 +284,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
>         mutex_unlock(&ddata->disable_lock);
> 
>  out:
> -       kfree(bits);
> +       bitmap_free(bits);
>         return error;
>  }
> 
> --
> 2.17.1
