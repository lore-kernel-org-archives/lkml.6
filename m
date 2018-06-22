Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82657C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98F424918
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dmjY87Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98F424918
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeFVVfu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:35:50 -0400
Received: from mail-ve1eur01on0091.outbound.protection.outlook.com ([104.47.1.91]:9504
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754401AbeFVVfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlZGjwWpCfMUBiU0MVHxcOEp1Ae9AQ9jQgfD1zv89ww=;
 b=dmjY87DqxBi5QNsKTVE3puIExrrbxSrKLwQPuxWDqh+TihTCjiCtpBTvCjcVr+mGFGnkcmvKHnn22c4MQMjpHHrT+kN/b/lO8sJBA09mdks7xEGteD8cEuHI7aodJfWf1Zmrt/iWy/3FkMV6kCjW9hpiVIcfTRe9AsqQJLZJkXg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2455.eurprd02.prod.outlook.com (2603:10a6:4:35::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 21:35:37 +0000
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-2-boris.brezillon@bootlin.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
Date:   Fri, 22 Jun 2018 23:35:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622104930.32050-2-boris.brezillon@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0173.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::21) To DB6PR0201MB2455.eurprd02.prod.outlook.com
 (2603:10a6:4:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a246b67-a53e-43b0-d45f-08d5d88819ac
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;3:lRv+shOTAlskOo+JxriKe3RnUCa+upNG9tbewVaXG6mGbssb2KJFP7SGXzWmOuQ6XPPXUc8XCKNcmX0pUs8ZI36M2GktkrnFmyJ8a0mI+q6AS/9z/vkrF2rSHuV57wa23/CbFk3BMdn6M34pgLrzK+hdvaeM404cBbb/NToRuvIKVRDIdS1CcLUGhbgJjY6Ddcon5jaXAFxl/iJrUtC/YWSZaFbQIuLSWLJptWcnH99s/3ftO3z1soYR1aA6fmuF;25:jVEfCZpuKXEZ0z8l1zhwW31W47aiLLKEvpf3DqvuwxcUVgGub8D5xawKi+GssVxY/mbmdCjAFd7QTPmRVAsKy/qi/ekL9pHr5z/rAk+In9+/MoW2jIkgv9QN5l2gJaYMyOZVXVvSTTaLRlumDPHk6JOwRmEhSCGnCmrHeaCJbXQ93K/AjaVyuLlDkbmBRF4GFJD/Y3aPM9w6ppcx2THsOLX4mBNC5+UwEWe19XoUDkyCOJeZ7wOmQ7t25k6T7oVMgChAbppewuozQQ2ezop61/lW5oyJ2fjMUBeyVItghjFYGWD6cQBOc7KXrJEVRoTX9zHoXVH8T/aMS423qqE2BA==;31:pN6mURwLIO0kabsEqF+QabxA7UHga2JwfqO5+nKkaLbr1wm7D72LkWd1ZwIOmyEOrJsWtQruO/fpk6cisZJMY1Vr+iOuzbFmxlaX35WLqOGIYhfzgPMKTQu+IPrtI3LJqkQlIYnFfTWyQtfy3nh0e1GMtKLDtGegjtrmmIT39CvCYypUBcOZ2dNNYpbOjh06ExxJQkxhmxRj0hg/omft2r96nQzceZIkQBeXU2CFGMQ=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2455:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24555AD8A0EC2AA8A5BBFFF6BC750@DB6PR0201MB2455.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2455;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2455;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;4:tEYUXWpraghDMbL4SD+ZrBjXRM5AzA7XgJ1mSZ9ZioeCOC3MHvEPCeyGgzpljGlC+WR0BAmOzpPx6PiVb4lKPUZnIjuMLB5yqJqIzI8rOK1+PVjyUkjGMHhzvtI75b5h78ac+PM316c2kqpQT6cOYFxTEa3eqWzheX4kVBXVJ0bJAF6HxM0haAG8UbO9UXqPhFMdO8zMyh9IyTAIIzARxh5Tjo4khcMbtJbELQFKX75YocP/iL6pAj65N5n1YHmFxW8P21MjNU/BmpvWScUCJmNknAuYlnf9vSXIsWBzbjvMuYeYI0rBnmTqarsiiq7P
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(366004)(39830400003)(396003)(346002)(199004)(189003)(81166006)(47776003)(16526019)(2616005)(956004)(4326008)(186003)(117156002)(66066001)(476003)(3260700006)(25786009)(446003)(6246003)(53936002)(486006)(229853002)(8936002)(77096007)(7416002)(36756003)(8676002)(3846002)(5660300001)(230700001)(68736007)(97736004)(65826007)(6666003)(11346002)(6116002)(81156014)(7406005)(478600001)(86362001)(65806001)(65956001)(31696002)(50466002)(36916002)(31686004)(23676004)(106356001)(53546011)(386003)(16576012)(52116002)(305945005)(52146003)(105586002)(76176011)(74482002)(26005)(2486003)(6486002)(54906003)(8666007)(110136005)(316002)(7736002)(58126008)(2906002)(64126003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2455;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTU7MjM6LzI1VTdzbWpqUE5XTVQ0UGRMcFZKSVFB?=
 =?utf-8?B?cDFMU1VOWVVsaGpCdDQveG9xZ3oxSFk0ZXkvVUt6WTQweXgyYXhKUit1OTJ2?=
 =?utf-8?B?S1RjNjlTU0hBZ2JZcGpwdy9MblBTVGtIMW52SkRzTEVTcDZVcWZ2dnQ4aklM?=
 =?utf-8?B?blhvWVB3VUxmaHNPMUI3aGE2a2laL1BxdUNTNU5XUWQzMy9UdnB5S1ZIM29q?=
 =?utf-8?B?TFdLMEtSeWdsRjJNMkZKaktVMVkwTElDRUQveURsM21mMGxhTVdWcEdJbm5U?=
 =?utf-8?B?cmxFSnJrK01lVEZTMWRoUjk2aUd1WWxPRmtnZDlVNEVjWUIzZE5SZDMwWFVx?=
 =?utf-8?B?K2hNUXdKbVV3RUdBeVYrMmw3d2wydVdmcXlFQ2lwcHlOSzhyTExBa3gwNUZT?=
 =?utf-8?B?TmlNQnFvMVdEbEVpMVJMVDYyYlJsbFZqV1o2S0ZuZDhNVUZJVWptVEdOZXlB?=
 =?utf-8?B?V2IweGYyRXdvWisxWk1BaEdicUkweGgvd1hGeURMQ2VvTTNncUhVUWNvaGRk?=
 =?utf-8?B?dmIzaWlEVnJrUDgzWUZCYnlaRlR1S3RUdFFOUXgrcklIbGFSQ0hOeXlBTzNi?=
 =?utf-8?B?c1llU1d3YWExb09VdGJMbmdnbkxtYkQzNjg1SGt4bHNEVktzempWcEpTUCtI?=
 =?utf-8?B?Y1ppZ0YwZ3BhR3FiUmFFSXhKbGRxNDdrSTFleEEwY29zdldLZTZpVUE3enUr?=
 =?utf-8?B?YncvRUk2RzJoeVBJZGZrb29GMFBlR1pvVzJSUjQ2dTVrNm80ZG5ZdE1hRFJ2?=
 =?utf-8?B?c0lmb1VzUUpmSUhhNTVZQUc4YmM5WE1rMmZ3bjF4ampWWXR6ZHV6QnNKNVk2?=
 =?utf-8?B?V1NuMTYzTnFBVUtUTVMvbitYS05nT3RsSWRoNHgrWi9JWDR5TzFCK0QybGhV?=
 =?utf-8?B?c1F1MXROcVhDTE5DYkZRYi9DQ3M1b00rTCtMWW5wdThpUTJZT1E0b2k3blZv?=
 =?utf-8?B?djVsem1Kam9ybENzZ20xTFN6dFFUeTF1Q1VXc3JsOXN3bnhVRWI0cmpmV3Jp?=
 =?utf-8?B?aGRwOFFKUmFLK1gyYi9lcmcxZnh3cXpwcGVKU2VaRGZCZTZtWTZMN2crK2hP?=
 =?utf-8?B?czdoaXkwc0dMZnVrZzEvcTNpb1BBV1gweGh2Tk1pZVRBdFhIQjNSN2FiMTBR?=
 =?utf-8?B?czFFZVNDemxnT3BNZFZYcExzS3VOQWM3dDN2T1l3RE45N1V0R3VCNmFxYmJS?=
 =?utf-8?B?KzgzUDQ0UXl5WnZSYjkzWmUrVUVlM3BkU3lOMlpsTS9ONTAxcWV0WlVERTYr?=
 =?utf-8?B?alk4RFNyb3pNclpnSVdDbnhBZEQ3VVhmWlVacWNTbDUvWmxmTzZkcnM0ck5P?=
 =?utf-8?B?M3YwM2pZak10MndrU2JmU3M5eTNtY0JQdE5zM2dHcEdlY3pRM0wyZE1DY2RF?=
 =?utf-8?B?bkRZVXp6MDNBcmErS2p2UGIzMFhEemZHWi9Ndk10ZE5qYnJhZjcvdkZtRmNh?=
 =?utf-8?B?dnNXd1FGNzhXSGwwUzBmaHZDWGVUR2lZUUxIQVBqRWVQY0p1M0h4STVlTmtB?=
 =?utf-8?B?azFVcFMzTVZPMWVFTSs4SlhLUUFzU0ZUb1JqR1ZTODFreW1ETldzY2RuMGpT?=
 =?utf-8?B?YktHcFNJK2hPYUhybVNncG9YazBBNVlLS0NHc241SHFlZTdKVy9tRlkvWFYz?=
 =?utf-8?B?RG1YRytKSy9KeEpMQ2NLcXF1dEdSdHBBVGRUNGRKRFVIdWJQTWtGZ0wwK2Ux?=
 =?utf-8?B?aDVmMGJPcFY4b0RoQnBWeTBxMDRLNWhZSFAyZDNFZjdjMnl0aUIxYTNrUHV5?=
 =?utf-8?B?UUQvRFdnQVVkayt2RS9VU21JMXNCd21rN3JZdUNmejR2dzB2cXkxc2ZrVldJ?=
 =?utf-8?B?cS9JcXJHWVFwRjBvTTcyV0NHUU1JVXh1SzdCdUp3czU3ODQ2ZVBrNWdVL1gy?=
 =?utf-8?B?TjFKWWhZTlBrZ1hNb1dLcW5rRWpoUnhCZUU2WnNKbGJhLy82ckc0M1JuNUVM?=
 =?utf-8?B?VVlXczlJNEQxWGw5dmNadXhQcGNBMkRQQ29XaUxkZmRmN1Mwall5cm9QKzVv?=
 =?utf-8?B?dStwVGFORFpJSjZIcjNGQVd3T0d2cXBOMHZpSEViandkR2Z4T0RETXhjOW8r?=
 =?utf-8?B?RTVnRStSZ2NJQ2ZLOFQvTUdWUEFtR1F3VTYrMjBoNDFLNURndW5DL3FZSmVy?=
 =?utf-8?Q?WUznaCelPqgAOecddNdxMg+KUZRniyF0vNPG79v65LiMZl?=
X-Microsoft-Antispam-Message-Info: 89JlP1Md3aSeJd5tlaUtfzb4UfZVZ/S2dziHKL1iYFB5ApY+FmqRSdIXveqv3UTp8hPXJ9faU16rOWOXbKs90GUR5WNo61lPrkN0Fl7MIE0tj8BoDH2Zao0nd52hDD5jCwuEgp1PHmNFxWQDctk4gWABKAG5laE5VVXPkHvpyHtV0DJR9ZXPnUEqlfAYF+cg+aJQmKwxWyotyDCYtktdYEVwQVMeO3T0rds0WAjbXJzkI1r+nuf+8TQyAebwhQqkeLJ7zuhpCtkWFcYav+fhB7E32aufbveFgdRnoCLB4O4cPQEDizhTDqGLx0KDrqsWer9nG1I9kBF63WXVhrRCqQ==
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;6:Nz1dq+bW/+vMTN7LPQO+I00+IT/w6A0mhadLQAMgybhZ+2eVMVH7SuOy0ZgRY9CCP1OK4IR6xofOVhhnsHEgPoR/hXJTC84JisPx+FI4wVQ5kQTVjL1PYQEFq9c8ce/c6HdrlZ/jaR231Q8vM9BxClAAy93zGFozil+stb9u0MWgyK6KA6cyY3m+CQ0FrgWdaXWXNbnXfdmUvsy9h24EfbMysYzilaKSJPd3lZ4+gddp1mQ5TXZc87smzj8ATUKm+0fxeH5e8ILf4d++ONUK93OnwzzAmjbp467ZNbct6VpayR+LD1uVGOp0JMPKWMMv0HzZJiLEH2qkxr7T3suQMlrOt9YQsi6qTV2YoeDgwTcYh81MUrp8PMUHxFcGnj13l2Bw2PCyT7nVC5zNihiX5RLxVb80DumIftwKBwvybAn15/2tgAf0Mzm8UOy4hzg3iI1d4Xke6FYkcJWVpsWyeQ==;5:LgHSRDLwfo8FajpRK5z3c8s2j0Ads4GEEOltbrW7z2SObXWJES5I1LxxOXxenq8/WlG8eFuyhEACN/NpRLEV2F6mLjdg/AS8eXNgpkUPxFD6QifkvqpTNdKyrxhpWNVUAO8w0a3CxrS7PBteZ+YN5n8AJDmB+XQbTLm8KWo4afQ=;24:G9evB7sB8JkA46c1OJ+qt2HGhwCZBwBSGJmAQqqS7l0m8WMemzBtTgwsSG7724AhAlUFo5wVH7wNrSxh9phHl9+rgXNtDUR3Q5vzuocV9WA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2455;7:bypEuJFvjC5fIh8/JbqR+kGrb0/R8MPUNeRxkLPgU9HkBjKHFOsUTlYD0JT6Zyj+LBwxWkWhbvc/AC2wQBtpECrLc8dvzs/PIOeU1y/Dg67vsrpsU4hrRGY8MQADQF6VRLQy1BctCP/l8e1qGoVNuUu71VmBUO4KdiOKn5GfZr6NT+ENmseG+ejUZXNuT2DU6OJ7llcbjmuMgMTlw6B8VMRRPn+SNTMLBwPypCW0AFVLo/aZqdP+YMf1polJsCpT
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 21:35:37.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a246b67-a53e-43b0-d45f-08d5d88819ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-22 12:49, Boris Brezillon wrote:
> Add core infrastructure to support I3C in Linux and document it.
> 
> This infrastructure is not complete yet and will be extended over
> time.
> 
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
> 
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think
>   it's worth considering an asynchronous model here
> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   like that.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.

Are bus multiplexers relevant to I3C? The locking needed for handling
muxes for I2C is, well, convoluted...

Cheers,
Peter
