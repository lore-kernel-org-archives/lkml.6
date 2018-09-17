Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB818ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C6208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="UdJeU0q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3C6208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeIQJAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:00:31 -0400
Received: from mail-sn1nam02on0084.outbound.protection.outlook.com ([104.47.36.84]:53280
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728585AbeIQJAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMuW4hqMmUV1ows5/jTtFWuCslGkAbhefMWiUKwU3gg=;
 b=UdJeU0q4dLzGnjxWdWiQM/qODdctaDRBcOn7OsUh9UXo3pzYeVw6Cv1urNoMuuIISkjH5rTBfXLMPyeIpqM01oUKBI9Cm0xgt784g6OD++vi1/uLmX9TW4KLfauMfkEvEKEHCXayZAORcW39arVZ6H5CoZ9SroBmWNKIo5luIw8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1583.namprd03.prod.outlook.com (2a01:111:e400:5232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 03:35:01 +0000
Date:   Mon, 17 Sep 2018 11:31:34 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
Message-ID: <20180917113121.3a885957@xhacker.debian>
In-Reply-To: <20180917112633.252c591c@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSAPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:604:b::28) To SN1PR0301MB1583.namprd03.prod.outlook.com
 (2a01:111:e400:5232::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d526cacb-a718-49bf-1154-08d61c4e8e62
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1583;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;3:Z9ew9Ja+MIV0fESr6jyv92TUZjwJhJ64Y+sEzvhadJ3pCqcN1BMuUDfYrvZwMKUhponI6ylmPsw0zHgKFsL3GxxD1zozY07YURAFSyZN8tXxZGZCYo/bZX1ZBuE2mtN2DkBOG63VQeh+YXxh0ul+0vk5yGk6VRDPzCLhOK3hFZA09MyQW2vSTKL6zYXelLSdu/CF1mSQH6klS0Yx9eHgzKdF2Qr//7AIFnFo8smjJBVlH4qiaJMVKVAk/vfLl13P;25:fr135lHzifSQFH07KgWDqpqkZFielD+h/4TnRX00CcSCZbCDRaykI6D19s6dlakZM4tbbZl4EMRzMv5belXReNoZ3zaXvNeeoGUMdghGHAq2FZgt+FVEBgjYRckUrY9jfQxgbSkqTRYeRlEDXQ9N9lwRdzC2xTLCNNbsScinw0E9JGBTYSKZpkQ9t7nqjZQlJNOyYlvkmfR/esz1SGzrczgcORfjdmOyXnXg9/4WjavVcik0nitdrN6/hNUD+cTI3T/cfwIz3M8O07mzmGI0OTrUTXt06gPuQc2vMqCIECa5ZLWVmiaozhcBzqu4HyTMXP5T3HL/RaWTDcx+htVlYA==;31:LDpDA2fGBjFRXTQyf4CWMMY63dOXO1DqoPuPcnhADws1As9cYKVVDhpSPMWYQzyjF7cfuVL6L2NFjXz0gNZ1Lvs1osI69BUo+sIDHHuZgvsiYdhWhZeKdu8hcjf4IO83u6HmnunF/ivievGy9uzXlKBB77gEXCrfMSNBm7v8w8fzR+AXjZ2Vtv/WH6vZp6OGEmxDALvWHkSy1nCeQfh1gOBNTMrUIdwjSeCEB8oifVs=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1583:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;20:tIZeW9WlSxsMKHJEqr/XC71kWaS6GVLOsyq+ra9qXuXrtGPEXkPy+1HogMmXDfoNODvSW5dYdncbCxcpgP4vlFJThr387/z4pe8sWraRrAbbXfmMgeLIZD6rKr18Clu8j7aYkPSlTvpjtsldYprXLDFZ62eXOllg4AhQnPR4u6zlhy6UF87moxgJpTB+f4GcPe6lw7Qj5mE50A1l2neGPgNal5Ul9k4lIlMrkMGBa+Aa6LAoNH3mTt0BB+RQVOW8djPSz1a38BB7xjjVny6HyRDHLI9GKwifZS74DrVWBbuA1YQxwBgnbJcxMra6Frn92xBD4XyT496UJqwWUp9Fdu2VqyiaFwHkY6mwa8Xu/EQ+ss2Nm5QAvj3gnuEJjWDNnGlX1JzkJCuUX/+FAJ6+MVq51PEM1HgtEfQIsb7GIS48Fa9GrMUCBEfTUBHPAIe2uTOV3SSHXcyyBFx7rNasFmtv9JTnhaqyc+yr6xUdvWymfaAjKj26A0rTXqAA4wph;4:KqpMhZiaM7sqGn7Si/msZVrakb1GXYqFyoZW6oI5WC58Z0o2S1TC8tCIac6c2J6gN6HQ+Mxpst2dFNjYPlZoj1LDB4cRDyEwzvTdGBAzi8xr6J7MWkBYgZyeyWyiO/ZXs5N+bcWVtUJK9wbT36Q+dNw4siw+OeRSVOagXNBXdn9NuK+1YBi+7gP/WxWt+w1LmmPTjwoJcGor9tNqnJRr2mF0SjSixXM1bejLyNZun6As8EVAqz34IXFXaUoInhL7K3fr4WZCLmz20pdJ84zvWw==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1583AC016D3A668596D830BFED1E0@SN1PR0301MB1583.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN1PR0301MB1583;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1583;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(346002)(136003)(199004)(189003)(3846002)(53936002)(6116002)(229853002)(446003)(11346002)(478600001)(8676002)(68736007)(50226002)(81156014)(23726003)(8936002)(33896004)(2906002)(50466002)(97736004)(72206003)(81166006)(26005)(16526019)(4326008)(25786009)(52116002)(7696005)(6246003)(76176011)(186003)(6666003)(86362001)(7736002)(47776003)(7416002)(386003)(6506007)(5660300001)(956004)(66066001)(106356001)(9686003)(55016002)(230700001)(305945005)(476003)(110136005)(54906003)(105586002)(1076002)(486006)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1583;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1583;23:TWn5XADu+a0Ks0bbNBnvJKGwVMfOIC+abcOwNYp?=
 =?us-ascii?Q?HlBeGixQYPQfUNiogIl/ycnPcht+fnB4t7kSYhl/tqG8j/AD4L1VmPXuZrSR?=
 =?us-ascii?Q?KX2H26qQZzVcoLSi1H/q5hvWjGTqdTrFo52G1AdCrKy6Il67SzKIGenO6GaD?=
 =?us-ascii?Q?uQBz4znMzRb+lqqDvpMZx2Ydj3aqcvPj2/CqP8rZqTF3oqYZMBNtkTH7tmKf?=
 =?us-ascii?Q?oQ0qilPGcSLV91ljXAYj0PoBLGz4b2b6I2KQ6m80WijDeu/Pivxx9ta5z3QG?=
 =?us-ascii?Q?vjt1/c2JVuJOuumpMAO2OcYRu38Lf4u4CBruktWT1+UXWVTpqsy76qYa3yK1?=
 =?us-ascii?Q?4MJ6wu22d+6QtPZtMzMQONG4YAm8vYkBO5otIVVsDjL39gyxFkxso6NJw5WS?=
 =?us-ascii?Q?z9gNNbbDczFB3OwIiRhpY9+scZkAY2RsKJCNxcQlIrSZJcCEe+2RfeNthXvw?=
 =?us-ascii?Q?oHZ1KJupbyGtLZBRn04aqFgnZUdHeSMyIR+88uRCt1qZzkJ5FQfAzk2eG3fz?=
 =?us-ascii?Q?BOBNFmA7lOe9h7PAOK1I+JZxGAaiO2fcNkhdziKPmE31r9rkZ4KutI803rqK?=
 =?us-ascii?Q?DjZfcxD8/lfnxmI3Kk0OS5eF9D9efJb05j0HGF9eqqRQYXuYU8srqIirFCw7?=
 =?us-ascii?Q?TdvMc3sBHhDmCy7tRHtlc4g+Q5uO8BfH82eYh6i7vRfaCtlQG1JxqPx8LC14?=
 =?us-ascii?Q?tXccYQTjsuNcfhfE/ce16AA/To/7EM0cB5Iz8GdZHtUfQhuY0g8j01zZs5pV?=
 =?us-ascii?Q?9W6RZB/OrM5UnnExbCExCbW2NM2+NxPWcakpbvEA37YJ4INhn1mylKLshRuW?=
 =?us-ascii?Q?qS1TZ7ke5bEw1w437TS2xFpk7kS/p08VtKiwtGANG7JTVybCJUhWv7xUjbpN?=
 =?us-ascii?Q?bMAHzCq/QV+cQIVMAggZ638bR8szYTh9yYeMhXu6NZnmQLALUERcNnEWM60m?=
 =?us-ascii?Q?WpWK+WyO6oLHKi3o3pV0vO7ELuDLOg5f9PkUEmY6bRs/LrwjRTCsQrl8K+3e?=
 =?us-ascii?Q?C8qROUr8fgi4LSukhIvMXGBxHdJ0Iy1a8oruJPb2F0/bynfOY43bw9ypu6yC?=
 =?us-ascii?Q?HCyXEqTd/Y2TBPYUNNL0l9v0YmIr45l6NSvXhyt1cdF1TG8N8csWPxESASK4?=
 =?us-ascii?Q?BZWzNz6paE2kK/hTZ/Mzd1aExjc980gFSMVjSP2GLBI61BY4nmgkFyjivBMV?=
 =?us-ascii?Q?ssQsUh1SeyAieGDcnzSUd7i8pyq/xpabb+DksPCoPUzAuV0PdOhCToDX0p3J?=
 =?us-ascii?Q?U0dD8CCsQxkirjrtY/4Kdp9mA4ajN43pyeKo67yDUe0sngCWWWNsrg/3unI7?=
 =?us-ascii?Q?MpQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2lbThMnnqmbtqr7pU+pTZa4Boe9rW4LLEzHWJTnYeu6GDV68tnhFYypthGkAjHxQa/y8fIB0uN/OgHiRzKof6oimJNhJeZEhGYMA/MLwvYqQZ9bf95PND5KagXs/uvwO2fLfr6DCQagEk+38ok8LtTU/sQikXWuYCCHEtBzt8geSBXbKnBnp0mJNDr5VB0d8RlthqcKZKKZcplcIio8YqiuMxYKq4GFN45VmnuUY9L5aedTnHI0bjNoJwdh2EBTP7G41PfxiJoZLKoXvRMl8Wx7AylnHWJKM/5stmdpa221soxgGSWCbF3ZoZiVq0C6xFqhjMbT4+ElCvJYerOsJfqVmfYQnpbwEwneh57aMzvA=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1583;6:stHdsm7feLCWU2Pt5BkYSyV+5vRVrebVeLs2/NujsvVxBbyEQPNVkdgbXLn7xLyqqX0RMZ1DYvSdjAakLQnly0Q8dUz4++RCRDnluToEwbSnklR0kMlM/QXJ2TD+tIf8Im5VaNm+kQ+D+UO/3Prn07nFBtEZYUblTvtsHdFtwwJVYKFORkFIGKPEQCSVGsw/fWU0YN9DVeV/jpagCw4W8c+JQltdkQ9Yiot51y6ZMmOvb3Yxu8aaoKDVdsAm139yccQhm7IoTjJyz064jcvj28soa6Y9Bo2x2vdClvU4wlZTffZ2SJhUL4UUDsCeO3kcdIQHbIP/EtZzGMXOlLcx7oO4Bkq8AxFi0/JnmParKoaZkkwMsRcXZ8HvylWKwiuc37VoGeEll2CmvyEbqa+W/3dKJT0QX5OPMYhYXKB0wWJKcp273vcmo0MwBGtGxMJ8wQHaEMam0m1RO9CC/3G8PA==;5:6YuBcH3asxPBLZRpL0+tEdJ8MgnmozArmBcwWr/LA4GMRAZayVdfRXtayj6pF96KA6YnI7qL924iY0FWe4VMpDrJ511h5/p5bT/o2HaGORt1TPh+4G+oKCXsrfvE44IRj/1dsYvT8FJW4yjypzMhENEX9UeNkA11eyWiVfqTxqw=;7:Cf3+HEGusm3x4wfqeT6QMjVw17P0SMIAPIM6BbCuS9UAiKtYPTP0QExpxZyrheFNDMPHi1SzZYYS167b43jISc5kJPufKfJL6Eps/9nQ4QHgVTVONIHIPEBzbGZpMxJk5E1hl65qy8+cHXH/5Mbto+KIHjgmPkSUe6jhfUZMwQMcxvIs23RjKIIEe45/f1y5evkuZwtfgrbqE1d/l1FKu9UqW8vBJXfQwXB7zMu8PGxTbyqIf7OmvMOPF0PvM7fk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:35:01.5431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d526cacb-a718-49bf-1154-08d61c4e8e62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ DT maintainers

On Mon, 17 Sep 2018 11:26:33 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On some platforms, the sda/scl pins are muxed with gpio functions, so
> they could be used for recovery. Select the gpio/default pin function
> when prepare/unprepare recovery.
> 
> patch1 adds the missing scl-gpios, sda-gpios properties binding doc.
> patch2 adds the pintrl property for i2c bus recovery.
> patch3 selects gpio/default pin when prepare/unprepare recovery.
> 
> Since v2:
>  - add missing property dt-binding
> 
> Since v1:
>  - use IS_ERR_OR_NULL
> 
> Jisheng Zhang (3):
>   dt-bindings: i2c: designware: add optional gpio recovery properties
>   dt-bindings: i2c: designware: add optional pinctrl for bus recovery
>   i2c: designware: select gpio/default pin when prepare/unprepare
>     recovery
> 
>  .../bindings/i2c/i2c-designware.txt           | 12 ++++++++++
>  drivers/i2c/busses/i2c-designware-core.h      |  3 +++
>  drivers/i2c/busses/i2c-designware-master.c    | 22 +++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 

