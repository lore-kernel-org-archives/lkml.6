Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B8AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCEA208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="MOT/bkVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DCEA208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeFRGLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:11:50 -0400
Received: from mail-he1eur01on0089.outbound.protection.outlook.com ([104.47.0.89]:39840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754724AbeFRGLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukXcyrBp2jyUo5u9+ukdewaDTCkeV8EeU/WBKCHMlPo=;
 b=MOT/bkVK56pjt6bPHCoRZdVSs6ZWOGbxif/rPKEADLLDlHJmlCZmY1PSXg2RLblMogJwxs9Tc2QJ9vQ462mIXQJmiWmxvFqVKO4vownkYaAjLasIKhJPFep7SsD7l1dJxrId9uUiSsN9mYqlWNo8PjuB72nqYMeMqbEyebjzhGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 06:11:43 +0000
Subject: Re: [PATCH v4 0/9] xen: dma-buf support for grant device
To:     jgross@suse.com, boris.ostrovsky@oracle.com
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, daniel.vetter@intel.com,
        dongwon.kim@intel.com, matthew.d.roper@intel.com
References: <20180615062753.9229-1-andr2000@gmail.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <c5ef52fe-3a71-7a90-0723-6dcb18c564c7@epam.com>
Date:   Mon, 18 Jun 2018 09:11:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615062753.9229-1-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:203:69::12) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a5830b7-ad5a-47af-e1ef-08d5d4e25def
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:3zzMwazX4aoNTuhNaRdhGNgGq6Nf4d07UQUKwCTajQ5qPWiAvEXMifmbwB2qfPXV953UwtxcufhRV6FMMNQgSrz/WWYvoddKkx9kqcE0O5a66Unm5AZntrgqoWuuC3LysdL+1cecCUdaUjrqgQ33QWecuMxug8JxGo0Wf+W9QFjIStTkom//8Rs0MHFIf8ZWb+RmUWRaMMxbpxIPXv0waOXYENGWoC66Fqxgt3CCKJ2FWp4UksrhkFxsmr9Gaaus;25:tW8L8qW2XlMuyED1SalfKWL9M6bv5ehujcz64tfCTbpaTAFRQSLqH/41aquSJOWEsK8D2coB1K8af0bUrTsrvPBMOBv0pDdE0KIu3G3WE6P6o+XfgDYIMlhpTZe9wg/I4rQiuc5kNsHsMdYHgcC4c6tgaAIYEIZV1tMFZF2YOs5XDeDEmRDmYeD1UOQWb5AhZWscqJXdvsTvF+3OHmWQa5bcoYKXH+PHpLo2fGqfDlzZfXLbLa7HiVIQyevEFZG+w84okJCDWaHY98YOiQEMMwi+sb+ujMwJT2kya3kU7+LxQ00F9qRrNZ4BwLFUfMB7j7GLEpJnML7GlznewGdv2Q==;31:l4nKCJLmLxEMCh7UTlHWZKQib3AVqv4QdweNheCvmZnsPR5VIL4M4zvwhal5obYbrwuxQ8BzZHc+Lnsy+1RQYs69Teg5VpI51HCN8PXfaROTLNsW17THoT9g9ZFDpvhl3l2E0nWsVm+lgT/XGLkh/2R9GDCnHPE7NPH3jig1ebaeSTSSqygP2aoi6WFKKsLbQWHRrxe4ZUAknWCmFdcWrehtAZ6TA/1yabnSM7XOPOk=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:H84DPuydsHNjN4fpn9L/n3EMX2l8VpeAsWvQEm+obQQgOTclQk3/gK+rNm9gy4QAMa8XTBu2RZ4UeeaXYk7KS2OuGqfItpea6Y0J+YjiG1ehp2af7ENZ0CxfNsyl9UGeKfgJx2OPryybXb1mQTfEv/SKZfw2dd6DqFwf1Z3uWt+Z3aQY0tht3+OJGtBNF87mCgJRn1d6Zze027WrcqCo80sRrZj+ooOHB9KaOul2iLsMbgRa8CQQj5+kktCjpT/dlLj/bGDG9GBhP6a4UoefAlsuX/RUdSEfMihPtssP+nxC3jZHNM3lGSOP1TzGao4E96so3/I7oEBNdTvrRDV8gqPXcGepZOjljmg0hPYkRwxsnmXLdfqI0T/0NVKoJ3C6dWuqDam3PIc8KzMF3QnvtNK3PhpKehjiF1X9OMAZPJMz62NJMjNxrCX2sJtHW1ZmaFeI3yRUfm6egm+9bStQApzNPsBX9hnxg+CpIDLNGrmehbB1FFRhH+M3+lTRy7Iq;4:Oax9ahQATYjVufK2aOuLDtGAx361SMH8VvRYhGn059vLr8enPNtLM4gQGz3EPCHlvchXp/Y/DuTsSPGYcE+pgoCdmOsaFVfjE3pcfo1FMn7juqu0frePpHtrkcjo2aRdqO6lAnmn9/scAD48jYwh/qL5VrX4HjNWZJaCoO7/+ZhgCFW/ocUNu3sZLTMQ0Cx/vmgbjzw+s4VF95Yt2c4qtFe6hZToDtTVB+vIfiUidBsiriKq3T958Whsme4gbT6KU4zRWJPbjL/o6O+smff75orLw+RnMZYxVBh9OUHwqLvQe7DZVD6N6uaG1wvjlBk7uZlJkYl7jgffvn3dHlT+/hhu9mqW31unCjH/5jE2+OJC8LypkFVl7M+cMbdcud0NToAKi7YWOTGVWZmefWWGgv3d8iydD8/bkoueP1/2UyQ=
X-Microsoft-Antispam-PRVS: <DB3PR0302MB3211A819CB3417C59CC42881E7710@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(58134797142442)(217544274631240)(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(189003)(199004)(504964003)(81166006)(86362001)(31696002)(81156014)(2906002)(52116002)(76176011)(486006)(97736004)(23676004)(2486003)(52146003)(59450400001)(55236004)(386003)(53546011)(65806001)(16576012)(316002)(2870700001)(65956001)(58126008)(229853002)(6116002)(3846002)(66066001)(47776003)(8676002)(68736007)(6486002)(8936002)(6246003)(956004)(7736002)(16526019)(2616005)(476003)(478600001)(105586002)(11346002)(77096007)(50466002)(966005)(72206003)(186003)(5660300001)(65826007)(6666003)(64126003)(53936002)(26005)(25786009)(4326008)(36756003)(305945005)(7416002)(67846002)(31686004)(80792005)(6306002)(446003)(106356001)(39060400002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6NzRiRVFqbUQrdng2bDVBMWwyd2RCSjNJ?=
 =?utf-8?B?dFRQcEk5dE1Mb2d0UlY1TGhDKzlTYXZGTm1mOVdDTk1yLyt6QUxsZDk3UUpl?=
 =?utf-8?B?WDNwTzlxRCtkeXBENzRTWWo0cU9XNHk4ditJaWFHdEsxREk4K1JIRzBzMzBJ?=
 =?utf-8?B?anY0bnhHbHBMZXQzL1RnRWxQdHpxdnVFTS9IejNyOEFzcXM0V3JnbEFKemYr?=
 =?utf-8?B?R1dsWGM3MGVva2VHUUlyV2xTNjI5by8xNUlld043YjNnTzZIeVJaUmVrMDBs?=
 =?utf-8?B?MU5UNks1bDdVWWVSSE5qbThKejBLM0J3WHhIdUZSOUhBR0NIc1ArbU9qL05G?=
 =?utf-8?B?RTV1YTZiOXY2eklMaVpCaFY5VUxaOEJnbkdMSzRWRGFWK0g4VU9rOUtPa3V0?=
 =?utf-8?B?MXJqaWdYOUttQW5jak1CWDJDcGppeUFtZGh6czdzNGdoeXR6ZmxuMHBnOWNl?=
 =?utf-8?B?VjE4U1FWZTJhRWQvVlVDaWFjak9TVVVDV0Zsdm1NM2I2YTBJUTJQeTZSNWFt?=
 =?utf-8?B?MjR1NUY1R3hxT3ZuVG1iTU5yL1hINXlMdSswRENCS3BMcXlJdk4wd2xHdytz?=
 =?utf-8?B?TEQvZVpOL0dQMlB3MGFaaFJBSzZyNjlsUDVUcHp2V2JYRVU3RndqSi9PczI0?=
 =?utf-8?B?aS94Yk5EU1IwaUhaUUpwY1hkSithUEVYZ2RXQVp4MXhQbDFqakllMFU0MXhi?=
 =?utf-8?B?eFl0ZnpGV3dENUo4Z2ppTUhEUGFDZDRjRTNFMXJZY0E3ektYalVtQ2l3SWwx?=
 =?utf-8?B?ZXpUWDJLblNRTU0yaG51ZHVIYlRwT01adWpMbDlScDNWSE44a3VzSHh4QUhW?=
 =?utf-8?B?WHVDQ2tVSGhSKzFCSUViZkRnQmV6V3JmbUxqRnVpZE5uM2xDdlpJZ1dBU3dL?=
 =?utf-8?B?WWxCQUJpRUJ4MjM4em1GRTZBVFhCSEp1cjRTdWU1c0dMUFVRaVkyNWhCZzA5?=
 =?utf-8?B?NUtmSmJNRnQvdWE2YmExODVGb3F3M0YzSDl3ekNYZjNrbVhFb3h3SlMzN1Rp?=
 =?utf-8?B?bnFiTm1tNDNsQTVJYUErOTd4Wm51NHpmYWZJdzJTUW8vM01JMkVYVmQvOW44?=
 =?utf-8?B?QzZtdGNFcmtNOXJZV1g1NXI5TkdyQlhPbVJ4VHRXSWpsNzNvUUFrYmlvQkJQ?=
 =?utf-8?B?MHUyLzhaUy8vdktXZ1RldUxBOFhsSWFUWXJ3V1Z2SGhVSW8yMytxNWZLNWhk?=
 =?utf-8?B?dWl6Q0dXeEtNcERMTnhiUGN2Tm9zeElGWWJ4UDRDTUg4TnUyWkdoTm51WE5L?=
 =?utf-8?B?RzRFVkxsK1VGVkVjeit2Tjl1U1J2emt3THN1R1I2QTV1VHZQTmlPUHAyUnhr?=
 =?utf-8?B?VUx1d3dqVFlOY1RLUjNCNUxNdUlobzAwOGprVXZnRHg2Y1orRm9GM0N6VGFU?=
 =?utf-8?B?dUFCSDRSVTA0RDk0aXhDQjhkWFNUUExENzNKUDJWQXB4ZnZmMldUQUxJYTFz?=
 =?utf-8?B?bEkxV0xNK1I2ZXlEVlZlTDhuZkZ3MjBYWEVyU0Vhc3hoOVlyTFVpbW5rdHdw?=
 =?utf-8?B?dXh6Z3BHMURZRmdSSUlDd3ByWldvK3BmZ3BTZUF6OXpqYUVDbjZyVG4ySWJy?=
 =?utf-8?B?OCtuQWpzaXg0SXNud1hFbElyZ2VabS9SRlp2bFQ2VE1kZ3RhejRWaXhKNmg0?=
 =?utf-8?B?eHRVYm5oRHppY2ZGTmdhREFnTkRVYnhaRmpTUXBCNXF5MEZPMFlueDR4ZWdz?=
 =?utf-8?B?OVVTT1ZKaUN1S3lGMlk3R1dGYWI4R0pTYlJjWmtvNTJWSUsvWkp2WlVrMnR1?=
 =?utf-8?B?MTJONm9saWhBbGJoVi90WVlnUXNUckhVTHVEVDV4OWtYTmpkUkczNTBrR0tx?=
 =?utf-8?B?S2xSTjFsRUhlQ2pOWkNCb01BK0NienREL3R4TmwrcENvUXRXVXdmeEVFZmYz?=
 =?utf-8?B?bnJJYjFVV2l4aitDakxwRDFQWjVZUEFJZmhRZzNEc1FHM2ppRHhJL0NEZ3U5?=
 =?utf-8?B?WHhzMXl6SExxZXlsUGllNW1sVmkxOE5TYURzR2luSHhyMkxUWngzck5XYkRF?=
 =?utf-8?B?V3kwbVNuY0RLZWIzT1VpUDg5WXJETGMrQ01LTUlyZDh1RWozcTVlUnVxOWFw?=
 =?utf-8?B?TCtiSmN5N0l3cVpWaWFSQ21rSkxmT1g0aHc4TFRZT1ZCTE9nMDRndnc5N3ds?=
 =?utf-8?B?QnpFRjR3SG5BcWJ2eGZSajAxQ2VIM25jclIvTlFGVXlselk1RlRlT1V3Z0tw?=
 =?utf-8?Q?WMxiOK4mHsjJm7V3C7o3boH58DqHSOGmCTCn6JGSkIHQ=3D?=
X-Microsoft-Antispam-Message-Info: RMDs+yTOuRiO4kIBTIiIOtbjiEMZSzTCZ69Oc6APOgpNCLrSwJ1KlP1jS+tKjKPMlPlnucMHHl2sqgNQiUc//IDx4OSMxR4401/MiXTnFi8ZQXjGlvTCwYoeuIMq4Xf8o3T/eH8ojt69ZfcIBG6r8XJV/MQkjl7nvJDiIocde7WMRO3tg9G/f3hoilUmlr01fGAVY1r9gOIILxY/hLGU9bqEPTmkuULhIhdCQpQjhJY/noXMHcUK5bUx77+B02ZJ7oQakfDUzsYCIszT6ndPTzYxKoAgTVf8mDacDrDWne9n+sjZ95xVOBtZP/ytJ671
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:aM8+f31r7fm5fAC3dObYkW3ptHzpYxCCuj+D5mhjqrhiosUPBcT8GkQMDZIWiwzIUzCGn5chzB+vcwQj5nWYJ/+b5qq95VdiSgb3w7Bjreo42nhhwoRCO+59GkMaY1TXSRsmDRBrMaDS7YQk0orpsRiHX1RNIRzXoMxi8Ni3yPiTJw6V+Hyrs2i1jMjFMROAe+S1rYB5G/YPMI4r+/+6zuoH54+5Jds8C4uKSUiK2JeKXM034jXkhJW9Fi9DT0DPPyBTieq4B84Ixp0hhVGpMYu4gCNH8Od8vqdVWWZKXbsmgPEoTaD/SnpPoh58oTyAjKR3wXeWr93ZbaG1viOvMpn/t+5Pjree78N0kfbojJJNlv2ZK673zgNv5W4lgw9gumsKzONNKpX39VLgM/icMvcqsatBSSpltIUSvSHab0D0v124CsOEex/nTZvCh5x5qjU4VUy4YjkYNPrJR1+grQ==;5:mgcVz9kHyq9/l9/FUjrs1f8I8ZsUkk/tmdOiDDeRtcmadkIIXJOva6ORDUMSzRa3ncwIWUoFjFt1xDjBrVC32S7O7+r/EWga+5GAb4X/UeCGvD1tdwy/xGMoitWm6vVmzLWtDDVebGSiUi1mv+Q1tJMR2Phya6lHogdxvJomvgQ=;24:blEOducoRxmUb+covjLc3s7hQ2LmXEaIbzEcMvPAYRLxG7pZ6fOToE/7OfL7mpXlnmNc0NMAY8XNZN+EPR2NahZ914um8JN7831H9D2P6d4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:H7ZJbjAdfIUQm5R8ugimOxo5dQMWD61BolnHoA7YfI/52EYxELEcZDXP8nhEDTheoxxwcvYEZRu6lsLLL+/m/Gm2DPy4LIZzNgSV/iQnpZBjc/OQPxpOwEugwGxwy+Q/5aNYXqOJc4olGxdJPMrTwUKicJTscnFhGyU2bNlBcnUNUk7RWtO2SvM0YQfg0kW7uT2zDRc3ZZFcO0bNJ/ATz85WNBwOQv0HTEpkHdfx2HFgOjejJblhvBiwr4SdWSEn
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 06:11:43.1805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5830b7-ad5a-47af-e1ef-08d5d4e25def
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris, Juergen!

Thank you so much for your comments and time spent on this
series. Appreciate that very much!

Thank you,
Oleksandr

On 06/15/2018 09:27 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> This work is in response to my previous attempt to introduce Xen/DRM
> zero-copy driver [1] to enable Linux dma-buf API [2] for Xen based
> frontends/backends. There is also an existing hyper_dmabuf approach
> available [3] which, if reworked to utilize the proposed solution,
> can greatly benefit as well.
>
> RFC for this series was published and discussed [9], comments addressed.
>
> The original rationale behind this work was to enable zero-copying
> use-cases while working with Xen para-virtual display driver [4]:
> when using Xen PV DRM frontend driver then on backend side one will
> need to do copying of display buffers' contents (filled by the
> frontend's user-space) into buffers allocated at the backend side.
> Taking into account the size of display buffers and frames per
> second it may result in unneeded huge data bus occupation and
> performance loss.
>
> The helper driver [4] allows implementing zero-copying use-cases
> when using Xen para-virtualized frontend display driver by implementing
> a DRM/KMS helper driver running on backend's side.
> It utilizes PRIME buffers API (implemented on top of Linux dma-buf)
> to share frontend's buffers with physical device drivers on
> backend's side:
>
>   - a dumb buffer created on backend's side can be shared
>     with the Xen PV frontend driver, so it directly writes
>     into backend's domain memory (into the buffer exported from
>     DRM/KMS driver of a physical display device)
>   - a dumb buffer allocated by the frontend can be imported
>     into physical device DRM/KMS driver, thus allowing to
>     achieve no copying as well
>
> Finally, it was discussed and decided ([1], [5]) that it is worth
> implementing such use-cases via extension of the existing Xen gntdev
> driver instead of introducing new DRM specific driver.
> Please note, that the support of dma-buf is Linux only,
> as dma-buf is a Linux only thing.
>
> Now to the proposed solution. The changes  to the existing Xen drivers
> in the Linux kernel fall into 2 categories:
> 1. DMA-able memory buffer allocation and increasing/decreasing memory
>     reservation of the pages of such a buffer.
>     This is required if we are about to share dma-buf with the hardware
>     that does require those to be allocated with dma_alloc_xxx API.
>     (It is still possible to allocate a dma-buf from any system memory,
>     e.g. system pages).
> 2. Extension of the gntdev driver to enable it to import/export dma-buf’s.
>
> The first six patches are in preparation for Xen dma-buf support,
> but I consider those usable regardless of the dma-buf use-case,
> e.g. other frontend/backend kernel modules may also benefit from these
> for better code reuse:
>      0001-xen-grant-table-Export-gnttab_-alloc-free-_pages-as-.patch
>      0002-xen-grant-table-Make-set-clear-page-private-code-sha.patch
>      0003-xen-balloon-Share-common-memory-reservation-routines.patch
>      0004-xen-grant-table-Allow-allocating-buffers-suitable-fo.patch
>      0005-xen-gntdev-Allow-mappings-for-DMA-buffers.patch
>      0006-xen-gntdev-Make-private-routines-structures-accessib.patch
>
> The next three patches are Xen implementation of dma-buf as part of
> the grant device:
>      0007-xen-gntdev-Add-initial-support-for-dma-buf-UAPI.patch
>      0008-xen-gntdev-Implement-dma-buf-export-functionality.patch
>      0009-xen-gntdev-Implement-dma-buf-import-functionality.patch
>
> The corresponding libxengnttab changes are available at [6].
>
> All the above was tested with display backend [7] and its accompanying
> helper library [8] on Renesas ARM64 based board.
> Basic balloon tests on x86.
>
> *To all the communities*: I would like to ask you to review the proposed
> solution and give feedback on it, so I can improve and send final
> patches for review (this is still work in progress, but enough to start
> discussing the implementation).
>
> Thank you in advance,
> Oleksandr Andrushchenko
>
> [1] https://lists.freedesktop.org/archives/dri-devel/2018-April/173163.html
> [2] https://elixir.bootlin.com/linux/v4.17-rc5/source/Documentation/driver-api/dma-buf.rst
> [3] https://lists.xenproject.org/archives/html/xen-devel/2018-02/msg01202.html
> [4] https://cgit.freedesktop.org/drm/drm-misc/tree/drivers/gpu/drm/xen
> [5] https://patchwork.kernel.org/patch/10279681/
> [6] https://github.com/andr2000/xen/tree/xen_dma_buf_v1
> [7] https://github.com/andr2000/displ_be/tree/xen_dma_buf_v1
> [8] https://github.com/andr2000/libxenbe/tree/xen_dma_buf_v1
> [9] https://lkml.org/lkml/2018/5/17/215
>
> Changes since v3:
> *****************
> - added r-b tags
> - minor fixes
> - removed gntdev_remove_map as it can be coded directly now
> - moved IOCTL code to gntdev-dmabuf.c
> - removed usless wait list walks and changed some walks to use
>    normal version of list iterators instead of safe ones as
>    we run under a lock anyways
> - cleaned up comments, descriptions, pr_debug messages
>
> Changes since v2:
> *****************
> - fixed missed break in dmabuf_exp_wait_obj_signal
> - re-worked debug and error messages, be less verbose
> - removed patch for making gntdev functions available to other drivers
> - removed WARN_ON's in dma-buf code
> - moved all dma-buf related code into gntdev-dmabuf
> - introduced gntdev-common.h with common structures and function prototypes
> - added additional checks for number of grants in IOCTLs
> - gnttab patch cleanup
> - made xenmem_reservation_scrub_page defined in the header as inline
> - fixed __pfn_to_mfn use to pfn_to_bfn
> - no changes to patches 1-2
>
> Changes since v1:
> *****************
> - Define GNTDEV_DMA_FLAG_XXX starting from bit 0
> - Rename mem_reservation.h to mem-reservation.h
> - Remove usless comments
> - Change licenses from GPLv2 OR MIT to GPLv2 only
> - Make xenmem_reservation_va_mapping_{update|clear} inline
> - Change EXPORT_SYMBOL to EXPORT_SYMBOL_GPL for new functions
> - Make gnttab_dma_{alloc|free}_pages to request frames array
>    be allocated outside
> - Fixe gnttab_dma_alloc_pages fail path (added xenmem_reservation_increase)
> - Move most of dma-buf from gntdev.c to gntdev-dmabuf.c
> - Add required dependencies to Kconfig
> - Rework "#ifdef CONFIG_XEN_XXX" for if/else
> - Export gnttab_{alloc|free}_pages as GPL symbols (patch 1)
>
> Oleksandr Andrushchenko (9):
>    xen/grant-table: Export gnttab_{alloc|free}_pages as GPL
>    xen/grant-table: Make set/clear page private code shared
>    xen/balloon: Share common memory reservation routines
>    xen/grant-table: Allow allocating buffers suitable for DMA
>    xen/gntdev: Allow mappings for DMA buffers
>    xen/gntdev: Make private routines/structures accessible
>    xen/gntdev: Add initial support for dma-buf UAPI
>    xen/gntdev: Implement dma-buf export functionality
>    xen/gntdev: Implement dma-buf import functionality
>
>   drivers/xen/Kconfig           |  24 +
>   drivers/xen/Makefile          |   2 +
>   drivers/xen/balloon.c         |  75 +--
>   drivers/xen/gntdev-common.h   |  94 ++++
>   drivers/xen/gntdev-dmabuf.c   | 870 ++++++++++++++++++++++++++++++++++
>   drivers/xen/gntdev-dmabuf.h   |  33 ++
>   drivers/xen/gntdev.c          | 220 ++++++---
>   drivers/xen/grant-table.c     | 153 +++++-
>   drivers/xen/mem-reservation.c | 118 +++++
>   include/uapi/xen/gntdev.h     | 106 +++++
>   include/xen/grant_table.h     |  21 +
>   include/xen/mem-reservation.h |  59 +++
>   12 files changed, 1615 insertions(+), 160 deletions(-)
>   create mode 100644 drivers/xen/gntdev-common.h
>   create mode 100644 drivers/xen/gntdev-dmabuf.c
>   create mode 100644 drivers/xen/gntdev-dmabuf.h
>   create mode 100644 drivers/xen/mem-reservation.c
>   create mode 100644 include/xen/mem-reservation.h
>

