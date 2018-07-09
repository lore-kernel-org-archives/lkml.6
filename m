Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53588C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72132089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MwJaPcsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72132089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeGISTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:19:34 -0400
Received: from mail-db5eur03hn0205.outbound.protection.outlook.com ([104.47.10.205]:20685
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754475AbeGIST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS/1Q8RI+Z2Q2dbCRFOdTvow2rCmYwpyuQ+fsUw8ZpY=;
 b=MwJaPcszUVbkZntjS/F3LYqYWDvPGqMWSdb5oV2o0FJ2tZDiuux5g+1rIJljMYqtp4+l0sDqVnBvxrYwKmi9IU0S2t3r+vFxP0gBUB0KpB5D3Mto8onvdZ1FVe0yRrdHBs/vN2dQVCwZdj5E5nJNPYBykokJczouzNwrELVNZa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 DB6PR0801MB1973.eurprd08.prod.outlook.com (2603:10a6:4:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 18:19:20 +0000
Date:   Mon, 9 Jul 2018 21:19:17 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] KVM: x86: hyperv: optimize 'all cpus' case in
 kvm_hv_flush_tlb()
Message-ID: <20180709181916.GB3017@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180703134206.27240-1-vkuznets@redhat.com>
 <20180703134206.27240-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180703134206.27240-3-vkuznets@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P18901CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:4:16::20) To DB6PR0801MB1973.eurprd08.prod.outlook.com
 (2603:10a6:4:75::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a72fd2-8b3c-4272-e499-08d5e5c87e14
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1973;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;3:UAdz+c3XXYx278W0s791hYT9kzW6KXkXW+f65fMXDzgKG03yQAp9rgi/BrAtiYEn3wFx8BANpPnLtKRYqb6yvI0ayOJeOAochB4xk3tL1bpbcgfz3AGjH85Qtzgw+Qj8q/wJXWu3nnTEjcl4Z08p1H0YdxQmRTxJJ+N1OUM2ST4BNfHensJKRPmTiSfLybF1JQdqc6GZf2VlYJHzOwiAHJ1G/mt7jn2Jk2ZG0pMUjlxpKnF/XV/kK2HCcedRXIvh;25:8GQE/gr8cgfcDh1GVpJI5+y0W7MeLyk4J6VG80W9P29V6aGSobYI+i/r6lA5xf4q+eLd0TIDRuIVIXKAJTXGhg2O1ZmftwwfP8hGRwG4+mvcnYotgUEelKk/yrC/DG5yDGdg5hvFlOqvf/7I3jl1NiDy60V9KraLeStMf27k7iSb/B5y1x6cUsQWdyGX5jLpO492qcVFtuMNY5SLXg+8X8w2P5ij2WOinURA9ifGmwLA3W8cY8TL+HtjccHkrBKUc4iS5wvTLJkiZTVQ6X4uDhYGInkDv18B8IsOnIVwbWicdv139Jgk4aCtOcr9V/dxeq02r5MVJZcUj5Y+6TUANw==;31:hbUi8Gxez63wdNrdZMN1RQ/9rCMyeKGTGdaJ8rLwwR4rvrLHFycTzBW2FpqGpasgRTWCzkESujy5x92NCIx1iePDTyJS4JZz6bNuGFQiILtD1ziBvtm0LwDQleOef9FX0GTavF0lx7ztOWPXplrHz1nVixHL5yVf1ryaqF0TPFMyI8SKthvhnR01fHzjN4tqL0X3OxW3thqiBHOPnQLZ9HRHZmwhGHwsbK3GTE1FlLg=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1973:|DB6PR0801MB1973:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;20:R+QxrKPSBu6vAzNWD1gy6qlSpsRfXOV7h00G3C+dr3vrgedcLk6EFG7iSjYJQLNlr4SJUaO6MnB/mRYR8c86JxsW6jxJptFEgeVOmx+bAuXn0rU0rFVimGAMvB0gsEmmfeTG4LvKNTaiM7KWmB5T6BCoe4juOzSiBGz1Oi9gRDy5yHxa2r/eQj/LDcWZxylJBy7PzMhHfN4M/CMcxgLuSgxZbHF7bmq/xmAszwhcTDOMzeFsDNyggOmLTB7ye1mPU6wT/LORLCiYcOCvaCvUAxxLLIJN2Amp8xvEaqToKNLQbsnj6oKUabBQvmr9hJkWmXQImHojZpAz+4J3muBQortFBamQ7d5J+8utu+pwtF8/k1/3M1KTm9GxgMDZcCNullNcdR9QGifft9LIHz38hCPh/rLjtcjGvU5jNFmfff058pPY37DLAUT+lSb3C6I+HSJvMTOA4Sw+fQM4EmKK4rC8t/HK/ofY8M463pn4tGkf5fuqgDiF/NRCkrIUQsI1;4:SlHUPa0iGScDu7ZN9TBkOzZS63aSiyhju+7Jy/1JcT3mf4EHL4aFJcCB03d7YMDpR6zXUM+QyGet3azBXzyYVq0Gy5R8joJWyS0vhn65c8p0UapdiaaK8ZqPTcMNkYcHqcq3XtXIlJyHfzL5ksiRJ9iyAMMQE38/pE6AOs1wbBQ7IJct/eyYY+HJyJTqNcpvkzfmlYBm+1I0BqTGkydDhu1a1e+bwIShRgbVtLhB7K5MROkSq3bOHHIoRMV02QJyZEAsE4E623jpvWsaP8oK9g==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1973BBF68FBB54E054DA3748C9440@DB6PR0801MB1973.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1973;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1973;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(376002)(136003)(366004)(346002)(396003)(39850400004)(199004)(189003)(76176011)(52146003)(23676004)(2486003)(229853002)(14444005)(6916009)(2870700001)(47776003)(68736007)(106356001)(52116002)(7696005)(16526019)(66066001)(2906002)(97736004)(186003)(53416004)(7736002)(305945005)(6666003)(6506007)(386003)(5660300001)(55016002)(26005)(486006)(956004)(478600001)(58126008)(1076002)(3846002)(446003)(6116002)(316002)(8936002)(4326008)(6246003)(476003)(53936002)(36756003)(7416002)(69596002)(33656002)(105586002)(54906003)(39060400002)(81166006)(81156014)(25786009)(8676002)(50466002)(86362001)(11346002)(9686003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:DB6PR0801MB1973;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjE5NzM7MjM6VHZhNkhKVTVjY2FXMHdSTTNONmdyZ3Qv?=
 =?utf-8?B?M005SDdKaDZwL0gvL3A4MEl3OFRrZXNYVzBRbnNGVjFjYlRSZysyRkJoVjBr?=
 =?utf-8?B?Y2k5ayttSTdNL1NaZFFrUFVqdGh2R09MUXI1bUN3Q2YzeFQycExKZlFoSFpw?=
 =?utf-8?B?WFBOWkZpTE9VdytldVVoaFN1TzN4SjV4cnJBMU5hZklmam9qWUVtd3Y1cmMw?=
 =?utf-8?B?MWFlc1kzbmlBTDlXT1NBbVpWdUZ5S3RFOHBLUklUWWhGZE8zTU9aTlVQN3RL?=
 =?utf-8?B?bHNtVWwzNnZjZldjWDBkS2U5MmdmK3JIbUVRR3lOTkc4VXpPMjhhT1Nla2xJ?=
 =?utf-8?B?YUJlVlpNb2pBWmhVRE45a3RIQy94Ky9BdUFVRFc0Z0FTSWYyUnVsZGJSaWsy?=
 =?utf-8?B?L21OSHphakJMYmNVbjNocS9FVnovOTFkQkltM05YN21BM2RMSWpodkowakY3?=
 =?utf-8?B?ZE9LcWJrai9GZHhuZ2o5bGx0OExMSmJYN2U2QUkxNXpaank0MGkrN3kwMEZh?=
 =?utf-8?B?SmIxRmYvSW9zcE1oSGJlWmNKNFYxS3hjTGxuVUk5K0hvRmpVcGk1YVJzbm9h?=
 =?utf-8?B?MlFla1hjRzhvMDRIcnQ3b2FSWnlZcHZmdnFwaEppeGV0WW9ONGxUTnZuMkg1?=
 =?utf-8?B?dnN0bmVqdXFrUWphenFhbnUzS1ltWWJqUW1BdDlWQlZlQnlSRDF3dmVBUDM0?=
 =?utf-8?B?a2syRGNiTVZrME9GQkxTcllCUWlRTndsT3g2eVkraWJGQTNoUG9wZ1JhcmtY?=
 =?utf-8?B?bnlnNGdJVEgvUC9laUZiL3hBUTg1Q0JaTm1nSENnK1g3dVp1T3R2dEd6MnhI?=
 =?utf-8?B?Y0lhOGlESERzSVJUUEtDRC9NUStJcEZMMVhyMlJPRFpySVRFcEpqcW5idHZ6?=
 =?utf-8?B?WEdnNFRmeWpPTGt0Zi95Wm4xMDV3MUFSZFdydGlJbVVBVW9TYUpOdEpWQkRL?=
 =?utf-8?B?RDhLNThzWHU5b3pnbC9Zc1pwZVd6cENzeHIrRWtxemhLYXJUdm11ZWlCTjJh?=
 =?utf-8?B?Wk5hdEFuL2pSSHRnWGNJZjNvRXBRUnk4cFdId2tzVlR5V0pPNmVRdzF0NnZP?=
 =?utf-8?B?RG9sbkU3RHl4Z1Jlem1JNzJKUVloM1N1RkVYOHRZTmZIYmdtb1hTNVYvVkE2?=
 =?utf-8?B?YkZYd3VkKzhyWHpvZHZBMVIybzFCQ0k3QkM3WExORUFUdktqNHQ3dTdhcjVi?=
 =?utf-8?B?UTFDL2s0Rk5JWHZhdVhtcXBWUlFmUTd1NnNVa25SYjYrMUFtcU1vanFvUlky?=
 =?utf-8?B?QVhHcWlKNHBxMlVvb0NHSktkS2NscEV1bm9zN0M5bzdYajRxdktGME9YeWdN?=
 =?utf-8?B?L3E5TGlWQmtrN2hHeXN3Uml2OHNlZFdYK0ZPNStobXhiT3dsbTNXRmUzTjRq?=
 =?utf-8?B?NWpuQ3pDelpNdkxmdUl1QjV5eG0vcjdDaHFlVUVic1dFZVJDMFFNcFBBWXMr?=
 =?utf-8?B?NVlVNTY4ckRmSVk2dHZkd0ZVMG9qcyt6OTNPUkxSSG5LazdqeHE1cExNOHpR?=
 =?utf-8?B?TEdQMlJid3RVbGJ3cWJ0Z25KcVJtNlkzNWJ5NmExK2ZNbktCbWtCOGtIaTRY?=
 =?utf-8?B?bkg3ZFBmQ3JvK1gyMmFOZGVLSVdlWmJhSEJ6TTBmRVpRWUhLNjBuSXpMenMr?=
 =?utf-8?B?a2lSajM5b3ZiYmhlS3UwUTU4MjM0OEFQWCt1M09la1JqdDZUV2pMMGRvajhL?=
 =?utf-8?B?aGdUbk8vcXpYOVJCOWU3RnR4cjZlMUt3aE5SWkVjUGt2bGtvY0FtRFFhWjlB?=
 =?utf-8?B?WlY0UHZ6alQ1eVJVbHpoNEd6ckNoTzIrUVdMVlg2OEM0L3poZkgvdjVVYytH?=
 =?utf-8?B?dE05a1ZRL1gxdmxHK1BDRjNVRkhHdFJZcFJpZXl2RkJlTVc4bnl0aGNPcUpW?=
 =?utf-8?B?UFBsdENLQXRzVndzdjRUZ1dJKzI1MFR1UmZXWWVyTjRPVG0vRzIreERTNEZo?=
 =?utf-8?B?eXNrS0d3QmxTK1RsRXVxdlZRNFluUGEwcGNvaURmZFlwb1pta1VVNlU3bzB3?=
 =?utf-8?Q?3xUzVwOt?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;23:y5oK7EkBIfxWJ/qGy4X0W0nEFJzCFhMoOk7ovsex558hJ2oTrbFVTIMr9I+lwjE/OQVhJXkCTgbqrp2I8Xw2vWMvt9G1/lRaVomvkLLU87WUW23CrSMWVLGCYuJGb9JvBb3PNIRXTzPPqhrANufwog==;6:lRmAVptMY3l6YHPSHAlrYoLodLSpSeNu1LgFOOcUIseDgShcaoPwEKQZ96JhigiL8EYEC7IRCbGx8zIeJVl7dvq1gebDKfOLF1OOyrKgqOo3mMq0QrEyy/OSh1Hw2YsIIrniW63GWm/8kPtQp9gD5i7KUPFT3U6WmGVpPEnAemI0fvmtqIWL3gzFVTi401+J2wOqhO2H3fJXzi9iM4X8DV38ZM3z/c24YhTD5FoKBQkUprqUzeUCO113ewtsMBSJSmZjNy4qtNc368PMK7Ub4ZF2MxXeRGqNJKOK6KAYpictJKoQAV7rP5caL1JVBQ96KCGffb6u4sHUeN+gLCK2Q5FxYM6aF1BoJm9NfRQKiWpnDz45QGH/Zx+lYWw/w336JKWeNmprnnSfNYdFK0sTVrJqaGaOxGUH0y4/UzKeG3TolPaJViemWIwIg0bix9VAyiu/Dx13V657jA1sw1HqQazYmgh2KP3D0C18YXM3kNsAC3vd7GUk90sv0hvtzQ+/;5:CYwSH7ZyNtHGeB21EvejkzLqNl2ChPyjULI6GgaohLO/Ea21crsS8g1vc1gmNa4z/Fyz054eL9gAnxAU1i+votoK5n5lxtmEea4KwcmH+TPxLgJ7qhaz/S8uKEtNWIDF/0t/4bB5HA/jZuicBUFK17f/6Mk1pzBhXfEQqq6QI14=
X-Microsoft-Antispam-Message-Info: HImKny4BePuzXELa0/POS6ZO14yBlgdWc8589znqc4/F1w/N8miMUQJKTtWsE1JwwFgphC61tTzGuiJ1oP4ogzf77WxPLWEW2wDdWb3TSmjQvvAQicVDuAVgz9trXlN1dxOe2NtmHPvXlt/KeANIjA0i0c7E5IDT4awc49gRq7HfU8kJBATmiJaUZY49+TekSLVH76W5njsYQxjAbOF3Bd9F73nDQYEf4HWvZqUNKyVw7wUXipYDMxxyNgxIBz+im834ptnLlMT/0OMIE6z3x1fJRgGu07xni4Esn4EulcTMSjrkxxvz0AzTuwF9IVfYT6jrbP3RV8qqjc+vuNaPWxqjunl0oXL1S/2Wwo4a6R6G749njL9S3b66xk2/vFS88tVoNY+nxBAdk4I3HDaJT61R6/kOJMqPMKh1R0YnpyllIUR4PRGixzpTPI5sOBArQIGKx/cxMBDS5sFwp/K43Rb9batV/bJQ20pj08wHnoGynuI/DUSBF2BGCVZoUjdfFTLWPMTk4Rru1enZxV/uxZu/H1obdMh7LoAtEu7nxOWnfmVzw/CjxU3uFUAos0alk/w47FbYZuiXYrfbNzZZRg==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1973;7:yRWV11wWm3xSlC0gpw4I2GDLouYtQeon0Bh48wh2cAvLQka08UQY6Pz6r1WZTJDAXd2a8dtpvjPLJ3N/u8Nu4vEYKv87kLJghhjCZaIzIMtNUdS2ePcg2hdoIOeuAgExo5ucXqgu96iNc/Ze7RFa4TCL5gpG5c4N9l4LoctwyMljjFOyPWKE04CbPlA3Z6GnWeH4hmpShUfDJphj2UYjp39SD09RMrsoMhMXWy3VG8xKluvpuVxYyrgzxWQHX2x8;20:ic43S6Y/1CBiaDvPX5TMefH5pZ+JPBnoeix/B5k9R+8eIjWePBJJ1qZ1TFIhxWMMRys1xvevEIfm1/VmlZCFlu1YEUF23LcCAn0ByF0Oa070zn6pIGXWjOX/TW1fdY9mApA/FMejLcE73ediL215Fe6J4MXwH2h/nnF3vOHKbck=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 18:19:20.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a72fd2-8b3c-4272-e499-08d5e5c87e14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:42:03PM +0200, Vitaly Kuznetsov wrote:
> We can use 'NULL' to represent 'all cpus' case in
> kvm_make_vcpus_request_mask() and avoid building vCPU mask with
> all vCPUs.
> 
> Suggested-by: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 42 +++++++++++++++++++++++-------------------
>  virt/kvm/kvm_main.c   |  6 ++----
>  2 files changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
