Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880E42082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="RnzvPNtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880E42082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeH3WZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:25:59 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:23487
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726732AbeH3WZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBWd88EdDF/635BtRXPvlbTAslq33Vnvutr8ky4UH6M=;
 b=RnzvPNtMRGPcbPzmfs7wr83XIqH7tJlqoRQsay/HI+BIJWFGNPrEba3ZjXQ42Ehio+CukbE2GIyN1fvdbga4/WL1CDtUIJxMhBXXqhDLoJCSDdaW6o6KgrjBYpEHXuGsgU6Mx3XtKQVbNmuOZz/M5RLs2JUA0uFya37z50Di+y8=
Received: from DB6PR07CA0096.eurprd07.prod.outlook.com (2603:10a6:6:2b::34) by
 VI1PR0701MB1968.eurprd07.prod.outlook.com (2603:10a6:800:16::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.9; Thu, 30 Aug
 2018 18:22:29 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by DB6PR07CA0096.outlook.office365.com
 (2603:10a6:6:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.6 via Frontend
 Transport; Thu, 30 Aug 2018 18:22:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1101.10 via Frontend Transport; Thu, 30 Aug 2018 18:22:29 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w7UILqhk003651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Aug 2018 21:21:52 +0300
Received: from [10.144.185.176] (CNU1280CYL.nsn-intra.net [10.144.185.176] (may be forged))
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w7UILoFs003619;
        Thu, 30 Aug 2018 21:21:51 +0300
X-HPESVCS-Source-Ip: 10.144.185.176
Subject: Re: [PATCH v2] serial: 8250_of: Fix for lack of interrupt support
To:     John Garry <john.garry@huawei.com>, <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <robh@kernel.org>, <joel@jms.id.au>,
        <kurt@linutronix.de>, <yamada.masahiro@socionext.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <055f5ee8-4905-c229-0e33-6379cf65dfbc@nokia.com>
Date:   Thu, 30 Aug 2018 20:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1535620130-199328-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(438002)(189003)(199004)(51444003)(186003)(336012)(305945005)(53546011)(8676002)(6346003)(77096007)(26005)(11346002)(446003)(44832011)(86362001)(356003)(126002)(476003)(2616005)(7416002)(31696002)(64126003)(229853002)(47776003)(486006)(65806001)(230700001)(68736007)(81166006)(81156014)(22756006)(8936002)(5660300001)(65956001)(478600001)(36756003)(53936002)(65826007)(50466002)(26826003)(97736004)(6246003)(106466001)(2906002)(76176011)(54906003)(316002)(106002)(110136005)(58126008)(4326008)(23676004)(2486003)(31686004)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0701MB1968;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT061;1:xVVhB++ELP/PvCMIiP0I3rjVuqrylByfytBMPJDZK2cU8EgGVMrnnnfXq/OrFiVjoyvPQuETKpTFMcU4D42ow9bY7T0IKOoiRJxgBl8HGHUNiqP8P6HVFfVi1KOMkLwu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275d5576-f3d1-485c-7e9e-08d60ea58ba3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4608076)(2017052603328);SRVR:VI1PR0701MB1968;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1968;3:zgnd5wWn741YlCKfj2yLKmrIY5BVs0V/5CxjXupYe6q9Ftsjn+8AL4miwKecuRx/Mae/CdNNvC5T8wd7WAAG9iQhIFcmTQVBb3DH1wAFttg2GsgQ/het2miKPxeJhbMAPeAla2BwWsthkH9QHSyPRAl1Ll2xoqpYxdVFmfj4NqIuVKpHDyHLTfsiz3Ta4/5+atZEWClkSnxGjSLMFUQgJrgvFVPboT24Luq+TcPvq2SGvBT07p/Impyltc1fnTqjnYHiwq4myDEof16UKcVASSVWMnGRXwz7TcawG3q2VJCI13bi4GZNDRqANb2IvvqS4uoXBAH4wxZOY29tNqrqY9VneQ7KoGWxePKjyuAYuFU=;25:lFPUgJxdYGjL0XFsY83nUx9qpfqmM9dASAI4Oy2kesj030xvqBZILz0l3+p6QgFsHQS/VCswmEopIMaDYz9SGOa75ZoucgbMWPiNlYDLvJOueHr61E9miLc+jCAddWelfAdqUYB0szIL9ndXz7e7W6Q9vRjEcu24E7WppBH9wqWUd/KLNxaRuE40apMtz9get2iL9H7A2ht1NCXfNkpp4Gk90k3D1c7ATNZBTXUju68/xQ0l6pBwVjAYjI768+5NocJOoZon4VJnTntXSLvehbaanLTdOOIAlmsSIkd94Ftwnq5OR6nT9kHJCK7ui1wDlA3DyrcdQ3yTMzb3iG++XA==
X-MS-TrafficTypeDiagnostic: VI1PR0701MB1968:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1968;31:6fbn3er5WufZ1ZmQH0DSppDKS+yhB5tf9Pa5ecONDCK9YQ+uZlE1vL6gtkJRseR3AiUj5GTs+63mFQbX0a32GsTF/znYuCRhNEdePeE3Pxajq/gNnhS8kTkGYD1J9GOA4cDMBpYRQH9yGNINfUlye//VnQkzzFAnaHSlYkFqlW7dU0d+rwYowUeSnwiTuByNdlEBAggzFZKL9lcYyeVHxKsdjK9loZgjkNYuX/a2a6g=;20:RsFBMB6vYs1F6WAHezYpIcwBs6eLLyl/lPOQaa4D5k/VJr0JilmJdWNrNtsfKewqbdf5R+YuCk8m6XBgT/rPMEBm5cbDgygSCWMHx2uI7YmKeg2CZuZ33TYK7o2z3yD8Yw+aWm20rmW60TtsZULvysz8J8Oi/qvGgvy2wshzjMrdE4VDWbIRWXVeP+uPG9ERBQuAHfrwq81DSgqBjtW3/s+4DsUaAZs0pU6ovR/fLbhaanJFmk+jfx9ifzHtZJEugL2YqUmJEMDvpWZ68uwWBBZ5qyCR/ne2FpCilRyq4kVcY4VGp14QqprV0ntyGsoPvbWF8y9E9At6ICI+Um5P/kCru2ejazBrjAX+cbVg7NahZz5wkm0x+WpB/1ahFO0YEWOHTT7aX6d0TV+/vW5MRqUqrFTmOTCe8mV1QhhcRIPnu1dh39oIsPHDu4Jh8JF1cZlYvMkSUumAcf1Y3IlQTYw7jC2AJit8+Fl9rdsmNpijgZTkImFAaLhboRE8eRkVLwI6sHEmMxbZ6Bk9w0IfemiFqrsu29hv5DrTzps06NzStlyg7Xz1DnEffatqlmBoY8YhyfJnmmbA4xiX/AfRrQjLcTjhJ1+TX0waKIJQ/fU=
X-Microsoft-Antispam-PRVS: <VI1PR0701MB1968B13A8034753A4A015B1288080@VI1PR0701MB1968.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(82608151540597)(109105607167333)(195916259791689)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231340)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:VI1PR0701MB1968;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0701MB1968;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1968;4:0lJmF9oUjTd2XcqVWGkJV5yj8SlrMkDG2RboGtYmbMNy6RWwdj4bLJ6pyYIkfbVbX8OctoQfQ2q5yMjEuIeM1HbaDtI9bssSNly4yi9o7GIl57zfN2kRnyWZoc5fgOSru1hhIh23gKhKkxAhPbR2Npk6WUlfNgkQ3eufMcbpikxS2YHGewu2X0Em1hjiAhLB6v0ksW8E7BIOQZJJeeXUddYhhykIZD6hXz8GNFiTb9bHNNFZd+EBgS3c4KOLx0ofwJJgZ+fgZoZQI+olsmEXxne4KpF8ULtM/dAYYYfdUKPHmTtd8LvfGOLDnARjxvJloYKXmQly9dFXHGyDHB4qVmTz30Y1nEmrZ9qOA6mxPydSsez214gBjkomXVEAO8aKmPQImc1O8IYE/ojmCFJVc+C5dkyGoGJ9HU5gHrs5X2w4xrSPCFBdYGhSvjN7Zk2XxwkdhcWxz5pMDo/SmvvtzA==
X-Forefront-PRVS: 07807C55DC
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA3MDFNQjE5Njg7MjM6WElkdk5DTHNvUjZhQVlYNkFhVTh1c1VV?=
 =?utf-8?B?SkJyUUNRVHZnTjRjOHJFQXF4cVpDMXBzRUttMFNBazd4U0VEUXVqMEFMMlp5?=
 =?utf-8?B?eHZmQ1BJaFhVSTBocUNKRWRldXQvOGRtekJyYWxjYlFqUDdKTkUxR1FLMnor?=
 =?utf-8?B?OWJZZndUVEVIWVRkSVlWbXhmQXgwNFFEamtJdHlWckZlVklwYldML0xpaDl0?=
 =?utf-8?B?bkRRTWlnTmVuVHRxc1VvNW9aYWJ3TCtwYWJjUDhoNXZPc0hwUEZUUnRFdjJZ?=
 =?utf-8?B?Qk1jSTkzS1R3SzhwT1daYm9SZVhxVEVYZGx4RUEyZWZlRzd6YVhicjFFVGtx?=
 =?utf-8?B?NlZMVVd4Sm1KTjlXWGJPYWVmaGlSSXZ3TWtnTTNPL09zbEc0eVBTam1YQVYv?=
 =?utf-8?B?VDZwRkVEbVQyK2hjcHl3aGJtR0dHZGplVHc4Y1ErV2tqTDIrWGxyOUE5UER6?=
 =?utf-8?B?ODgzNnlqWEV2aEZCeEdiVTJUY2trVmtkWlJmV0dHci9GWFZJM2dmbGxwT3Zo?=
 =?utf-8?B?eXBJVjRTRkxEL3phNi9kS01Nd0NPd1l5eTZobXF6RHduNTNXMVd4Wjg2NkIr?=
 =?utf-8?B?VU5GUUt6dGJ3dVg2eUZ5RU9NNzNEcDhEdnN2RmhDdHMrTEhuNWUrSFRzVHgy?=
 =?utf-8?B?akIxYmhMREduTm5mMzNRaG80akx0M0JKcTJwaE16L1IxQVJxT2FSQWEwaUlH?=
 =?utf-8?B?UFA2UFdRUzdLT1BvTEMxZ0hTWWtHdFArNXVMNU9LV3N4UHVzSG5qK1Uxa2x5?=
 =?utf-8?B?dDBsblZUb1NMSE5aclZSTnlqcmZwMytTZlE3MDN5dlI4aUZCZXdMeE5iWlQ0?=
 =?utf-8?B?dlNsNk1mK1JwL3NVYUViUzFkK1FBU2tnbkZRUTJqTFhkRWhEQ015YWtUZHQy?=
 =?utf-8?B?eE1zUGQxU3BBQnpHOTFPVzJaV3ZiSlJRWklVTmFRUGRCY2RZSE9aZFQ1R3Fp?=
 =?utf-8?B?YWFNVHV5Y0JDN25SSldYT255U3g5NnZCY3l1ZitYbFZYWkxna0p5RFZwRkVO?=
 =?utf-8?B?SzhEZGZVV1pkd0tvdTVXdnorZ1Y4T21nZU5qVW5KUm12TDEydE9jMGU4alBu?=
 =?utf-8?B?NDY1b2MxUUl5NUYyYW96d2x5OE84dDlxMmFnZkpEaTRUSW1Zb0FEcC9RK1ow?=
 =?utf-8?B?YXZ0MitOUEtTQmFrSlpUcXJTQXBxSUl0UGhvWnd0KzczcTlFZVdveEpYM29Z?=
 =?utf-8?B?TzcreU1iaCthQkVDRzFOaDZ3MjJVVVQ4Y1RjdEFmZzJvbkJBeTA3WWtxR2tp?=
 =?utf-8?B?aEE5a2R1YVdYY21GNWhWQUdlQ2RkejBZM0JvV0Zpb3NDYVNpbzZvNzRUeXY3?=
 =?utf-8?B?TzBHV3BDRDZJTDhQeDBWOG1ybFdWd2FaWi9UaDduVXhLcVdZZitnbVJZMk1I?=
 =?utf-8?B?dDdyZkdKajQ5WXZUU1p0RlJ5RzZnQ25FQ21FeE95dmNXRXZHNTYrMWVpNCtw?=
 =?utf-8?B?bUtqVDU1dDBHUUNmVWlGeTNrMzZ2RjRlQmNNNTNzdG1US1dMSzVyZ0hPcWly?=
 =?utf-8?B?SkpNY0F2S0x4WFVJamNENTVzUVIzNHQxSnVoNVdaQVhJN2hZM2RNc1B5VHNx?=
 =?utf-8?B?S05TNWd6S05XdGRKYzVWVStmYStld0FxN29vQ1FxOTBYS1k1S3plOU55eXNP?=
 =?utf-8?B?N0ZtOGY2SlM1dThwdHhwTmpVQlBXVkpRWVhueW9aV2p0ZW5aNzlmaEppektV?=
 =?utf-8?B?NXNHTnJoOVNyWG5wZ0U3VnJlQ3YvOTJ4aFBoNURGaUFiL2VSSmMvREs1dlVi?=
 =?utf-8?B?eTRoZkVKS2lyZExCL1F4VWZlSkt6d3VIZzhZY1FEUk9BRndOd2N5andsMFEy?=
 =?utf-8?B?c3VEekZwck5mNzdUd0lGR1phMHptdk5sSWlkMVdKN0JrTHF5RVRPaFE0QSs1?=
 =?utf-8?Q?l2WbkFLnWlvJ4=3D?=
X-Microsoft-Antispam-Message-Info: K1X1L26gyajFrjqixYrq/n9bVMYyk8EP2RROXEOaS9Etb6G5ve+uCUlC6EPUAV+sz7YXp7pEuL+Ti9QuJJDv4V4HQ2KyTP7ro2sscFExgdHaRfQ1a3sfBPvL+QriqapdkdGHIhQ2jtBacd0XxNGEbUkkBa11UEQuDYH7sZlnnwASScZqhGCegx1Fw00QDxAFkl9WhZeHf7WWANcljy8Q1mApMQ5xNKXLcw5YPy31J3Gt0tUUZZkUSE/oWcU/Lg1NNjlO2mIlFcboWv+fAu2eUuVntPQ0wJrn7UXGu+nXw0UnNojQ/7ukQYt8ZzEFcvXVj/TrR/MVBdj0/u4xXE/BZo7suVLuY6pWUI+66CSEvoHVBBvAGAlkE1VMWGeNiwrjbG7OtoIFhey6HR0d4fBr74jxJsYXGLcrWlFR6jimxfEXUcVIxFBHC2OgvqfHq9LP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0701MB1968;6:NN1Nzjucf9alJZ+JBYOFqcqrv5uXzbVT3QxVdr3Q3bGyyL4EKSuMXdvabtnxWh8FuNHb6deKfzCrobMGCvmktxijoPrZoW07FOSKv9arOZeWwos3wxK7pcZqXNBgyA31ygcWsXtv11A8QsgPgCpMD/Oa0qCkeTkR4/RIpHkIkD6Ky/jnP6i1Cg1U5uUy3VRp1SyZtx6cQFyUP7CPpBdljimVEMTOfIDj0X3lJSe5+ahjaojxJ42IbirvM7Ps23+h4hqup0/6SeI+W6sCYCMKV2SNnHjx7pJp6XLP7MLrx0QbtWeG50uvmMlez7SgDXS4lTXU0YAUFG9zhG8iXuSnWDBy5e6222FkIbTnFPuOeQr8rUki7t7i3IIRRmDQqY7YNfshdlSQsQPUcT+/REbmfz348ixMP/VFtp47QaiUmbMS71h0qw1TYwgIX2T7RLkwf4MzLxfZBKlSJgDEWE1xkQ==;5:mqSiFKMOrBrRw5fN4Ka88cokCSdJJuSDfADehq+NLmZYaG7GttKIKxgchaUgUNjs+HmpFGVBVn7Nvzt6j1tVQD9u+T4q4AJScDd0NswJIKSyfEG8eg0KcirEGrYeOWV138+oQhJhlpg802O14oF5JgqZqR0iP1ymdjd8Dc++BK0=;7:wuuYgFv6nSVlftcYRqmkjoRaHaAG9JM4vNHzazlBtgkMdQee1rYwuMzAVXdwNiOc4Bls+UiCzEbRZMxePY2xUHsDOkgT8QpjDwFMRBPiUBgNPayfUtgb8qZjd3A8l/6ChOT9nXT8yMlljr/U8f8Q4NKflKB/AWYBLfKTKdScHDn4UqW7Dn4RjbCMU7HO7X0Bm3dpj1Ud6eaV0R/xv1xejf5sfDOyaqtNEbdkJDt2ZvZVMrYTOtr0vHIm/M0VqzXO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 18:22:29.2613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d5576-f3d1-485c-7e9e-08d60ea58ba3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB1968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello John!

On 30/08/2018 11:08, John Garry wrote:
> In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
> check was added for the UART driver being probed prior to the parent IRQ
> controller.
> 
> Unfortunately this breaks certain boards which have no interrupt support,
> like Huawei D03.
> 
> Indeed, the 8250 DT bindings state that interrupts should be supported -
> not must.
> 
> To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
> does relay whether the IRQ host controller domain is not ready, i.e.
> defer probe, instead of assuming it.
> 
> Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
> Signed-off-by: John Garry <john.garry@huawei.com>

This indeed looks like a proper way to handle both cases:

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
> 
> Change in v2:
> - fix check on irq value
> 
> Note: I think that it would better if we could try to get the interrupt
> 	  before clk+pm enabling, so we don't need to disable later when
> 	  deferring, but this is not a fix.
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index af8beef..877fd7f 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	struct resource resource;
>  	struct device_node *np = ofdev->dev.of_node;
>  	u32 clk, spd, prop;
> -	int ret;
> +	int ret, irq;
>  
>  	memset(port, 0, sizeof *port);
>  
> @@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  	if (ret >= 0)
>  		port->line = ret;
>  
> -	port->irq = irq_of_parse_and_map(np, 0);
> -	if (!port->irq) {
> -		ret = -EPROBE_DEFER;
> -		goto err_unprepare;
> +	irq = of_irq_get(np, 0);
> +	if (irq < 0) {
> +		if (irq == -EPROBE_DEFER) {
> +			ret = -EPROBE_DEFER;
> +			goto err_unprepare;
> +		}
> +		/* IRQ support not mandatory */
> +		irq = 0;
>  	}
>  
> +	port->irq = irq;
> +
>  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
>  	if (IS_ERR(info->rst)) {
>  		ret = PTR_ERR(info->rst);
> -		goto err_dispose;
> +		goto err_unprepare;
>  	}
>  
>  	ret = reset_control_deassert(info->rst);
>  	if (ret)
> -		goto err_dispose;
> +		goto err_unprepare;
>  
>  	port->type = type;
>  	port->uartclk = clk;
> @@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		port->handle_irq = fsl8250_handle_irq;
>  
>  	return 0;
> -err_dispose:
> -	irq_dispose_mapping(port->irq);
>  err_unprepare:
>  	clk_disable_unprepare(info->clk);
>  err_pmruntime:
> 

-- 
Best regards,
Alexander Sverdlin.
