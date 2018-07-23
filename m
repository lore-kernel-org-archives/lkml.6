Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9486420846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YMvvCwKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9486420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbeGWGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:21:12 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:63482
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727765AbeGWGVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEXLJqRQRDhQOZmTWYlQ1ts7j7xWwJHLQaBYzwGRiE0=;
 b=YMvvCwKuibhyKBsH428Ae37CPvg/kGcajsrY/QxGTO8+MbG5VVSXBOiz3KDmFIucE1aL641DqA7e7mJlBAYQ/YDkaJBzbuzSiKmkuhhsj/TgB43ji/kdyscNZ78eAzbkfeEJDBaHl1NwzI6FW9+gzom2ay29qkP7JAeCJDO3suI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [192.168.14.130] (79.180.242.13) by
 DB6PR05MB4648.eurprd05.prod.outlook.com (2603:10a6:6:4b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 05:21:37 +0000
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To:     "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
 <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <9d752b75-eab2-6fd1-f9da-09985966436c@mellanox.com>
Date:   Mon, 23 Jul 2018 08:21:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [79.180.242.13]
X-ClientProxiedBy: VI1PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:803:64::23) To DB6PR05MB4648.eurprd05.prod.outlook.com
 (2603:10a6:6:4b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26475336-2e48-402c-720a-08d5f05c2bb3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4648;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;3:qRQy2IS9gw2Ogs4a3RwIKZeE1RJDi+0RLpzhANZ2coAY7Q+MfSOeeSJyZg/eq/x5rOPQP5is1X16WS4hX1sE2tLIEYebdMsgmufvbHYM1dXmHgDzigqeEJCBsP9uc6kS92yBQodkxOIlJGm7rqU3pn1J/l/Dafcngpa0mN6BhEiPXhsVUcq/4cXdrqLDO86ktrIgaZYYBYgEZWcO+k+9dskgA7x5xWALBCbrEB+ZJEUZAoVEf4sqoOI99Y6xg2UE;25:2enMQZz5Bac5OHtMYyLVfxwEvlqgjiRgfQ9sBVVDbm4z/88PseMCUaT8KmKa+9wFB2E8bW575Gwx5YGORgeBColNLLNe8USvDWzZi+0HfuKFze/GPjN9R4ydPtpiekegyVG9YakQPxzk/LGop4tz6cYeSzsU+N8Q9xdI1somPM9MN5t67nYehkItPrnigCzAn8vjbBaEtDr5aO11Xsvana8aTVuDH/S8j/3BfkOkD2kQPCF6OE3pijNB4/nopqWiN2+BiPjHiJ208t3eS7UwwZ+1TNklcJdYDQXgsA30+OUddK2049dLXj1FjIuHZpgFdfetZty3ceYdXdkUj7seEg==;31:zukU5wWeDTMWPhn1rbOqrso3nod3cvsNJAlr9rrwCVb/PUAUiJy3BWD9h4wrIjN4XlVxiTXTgAUhFYNLXjoNXHzx30xDnavwje64kUYiPd1ux8bdj8lJ1rAXo1Rr9//iqzlCAf0X981jHSAPP/0uktxGLZbBDzNKHq2ktbzvi88R0SGBUq8DKo6cfKmJqlrAfD8uuY0hv5pfzZ8Y+DbD7cP6meznvGvWLhFjZ8Zd39s=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4648:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;20:IVOmPSCc/zKF3m7JEJQnjvwxIde1vVBwElTbcd4c3OAkF6AFL4N4ToM/SmeWLOEfuMugJvENTzyR2dgLDOY4Pyrq41o5afwiMwxu/MEK7blSAf4aV+nShPOtbgJqt+lMmsN5rxvjmzbHhNxqi+eSb/XUOHOvVU0Hcj0/7Op7dBPayB37LMqXRDfgYaVPhfsudtXIMXwRivEpYrKw9gmzduHVLorL9LkTn9Yfs7WtX1Pc6/uBM9haMpcBZqdm9eyJpRhUPPvifzGx4kpDfuzkE1IB2QUd8TtXLvDlg1qrBSN5v70Y5ZKyw2bgpA7DpcfAf4PuPSoV2Z/Lu5sz3BxjPgRU1tXljHoCXcKI/ECnFB4UmK/5d1D3nWGLePUrrP45+X9UYAb/rxru2Esz3rx8Ui1lLOILWyFJx3qLcWugeYZeXqecgNqZkc16MqeWl7fA/tkMvnoY4ihm7Nz+CRKnDenV677iaiaEdCoQr84FJ9mTWfEVVbXuGE86xzCvNV1G;4:YfSxKW58nCHhSbAuaC6W0itcD2NHgC8vCPtb3yVCjehDFsPY6SSK27OVZ32qjOuPio1ZD2qdFWzf/GL/HhHIqWleb3FHfIYxUuEofCuvxggyQ/QXb3Ofax/uvwhRwU3Kf0dhYcbOcW5lXkaSrEWU1+DVPClDHOuudfy44Sinij935ID8OIO1r02lz6iWQ7xmzqsKyPMZoY2//ISRUPh+dy422fqwbUQadvmlb+42iLHF8JWLVkhU2+wsLULkc0wNPNJjt4A4t1rA42jP2B98PQ==
X-Microsoft-Antispam-PRVS: <DB6PR05MB4648C5E0C10341834904AD7AD2560@DB6PR05MB4648.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4648;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4648;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(36756003)(26005)(77096007)(486006)(86362001)(4326008)(478600001)(93886005)(7736002)(305945005)(3260700006)(25786009)(52116002)(2870700001)(31686004)(117156002)(23676004)(106356001)(2486003)(105586002)(16576012)(81156014)(81166006)(8676002)(110136005)(53546011)(386003)(2906002)(316002)(54906003)(31696002)(97736004)(67846002)(52146003)(8936002)(7416002)(58126008)(65826007)(6666003)(3846002)(11346002)(6486002)(64126003)(50466002)(53936002)(446003)(229853002)(68736007)(16526019)(6116002)(14444005)(956004)(5660300001)(39060400002)(2616005)(476003)(6246003)(66066001)(76176011)(47776003)(65956001)(186003)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4648;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUI0NjQ4OzIzOlN4ZkV4dzc3T1FJK0xLVXFLRHc0aEI4L01X?=
 =?utf-8?B?d1NIU1g1VHBhR2ZRWXd4bGozdnhaRDdRTWcyU1BIWkcyZWZ6L2Q2enk5UlRD?=
 =?utf-8?B?ekJCaHN2RkZWVE9TSGdHYnVadFVxRzltNC9rMXNvQ2N5c2tySzlwT3dWakdD?=
 =?utf-8?B?UjdhSHZjYThMMERTMnkrU1FVQ055UzlJeDVsTUMvODAxM240MjdKdjgweE9G?=
 =?utf-8?B?ZlpuclNGamVwUnBmOXNUT0FCRUYwZHNCV013b3F6MG5oZ2YvY0pFODgrc3Fm?=
 =?utf-8?B?T0ZSTmVqRVIzMzYrZnYvZFRmSFlWVFlnWjZxdjl0RzNyKzFuZ3pPcVNoY0Mr?=
 =?utf-8?B?djcrOUVOYWtrRXFWRkxJQk9paitoRE5ZeVNjaFFJMzZoNGdBeGVsYWhJMGpQ?=
 =?utf-8?B?THhlTDJtV2xQb0JyUlVkc2pwRFpwaDdhQXJEcjBBSHJQYUNLMjl2TkFaRU9z?=
 =?utf-8?B?MW5NN2FueHRCTnFIZUMwcWRnOVNjUkMwUUlxTkFkY2hnK2JLdlVIR0VBcGNV?=
 =?utf-8?B?eEFTc0NJVTN3R1g1YzhJbWxGZFJjazErTVE2K0pvWGZ1Vm93Q3ZNaDNuVmlJ?=
 =?utf-8?B?bGNob1ZpbTNsS2gvbVdMeGpJazE0aEV5cDd5REhTOFBTN3YzWkdNd0xKU25O?=
 =?utf-8?B?M282VEpRWWc0ckhqamFQTEl1WEtSUDB6ZDdWMSs0ZmVBbjFYMDBzRVhIbWEz?=
 =?utf-8?B?UzRaUzdiaDAyVlRnby9iVDJlaWQ3QzZuZWRTZk5CODhxcm5MK3gvSGRFbUxT?=
 =?utf-8?B?T244MDlvTWdKaUczamFocld1SUtXZGN0d0tEV2s0eEpCTTk4SWFIcklkdlNJ?=
 =?utf-8?B?WkFGT05CUUFlZnpnbCtsNHRTejRBeHdYQWFxRVlYUzhEYmMzcmJDQ1BCVlZV?=
 =?utf-8?B?RldPRGx1RXhOYWFlMW9qS0o4UEZTanIwaXF5OXl0NGlDUE10R0lyUmRic2xW?=
 =?utf-8?B?UGovT0xFdy9YcTdpUlozNXVGTVIvWjMzZWNlQTFIRktreVZqdHJEbkR0VDR0?=
 =?utf-8?B?RVhsWW1yNmpFczQwUGJTeC9idkN6YkJ2NEdRVmJjVk5pTjBUQWgxc2FJdkhj?=
 =?utf-8?B?T0lVeHhaOTVOWnRGUEcrVExNVVp5c3BZbkJrSTZnZXJmK3JYWGM5U2lDcEVy?=
 =?utf-8?B?RFY5SlB3SWFVYXVBSm1rdG9VcWttK3JHQ3FtV1k5RzI0ME1JUy9pTjMxVC8z?=
 =?utf-8?B?UXF2dVhveERocTNlR1RSUFlsc3BWaFAzM3FXdWN1TU5yc254M1hXVTFDYVBX?=
 =?utf-8?B?ejZNc1JibE0xK1BLZE8xd2xwakltbXdnSWkrdERwS2RhRDhWMlNHRVV2MnRM?=
 =?utf-8?B?bWEvRWdydTRlWjlYZnBxK3Rwam1aQmV6eUlFYk5aQTE5UFFzOGNMMERtSkZP?=
 =?utf-8?B?Zmk5KzlkZWxubjZWYVVuMDdmZ1Jud0tTUFhWRm9nVEdkKzRkL0dYUlFTT2t2?=
 =?utf-8?B?VlY2ZitueVJFZHBZakVyTjBsVkdteFZsWHl4MXdTbWNoOVdQdzkrRC9FaHBi?=
 =?utf-8?B?ZlVxS0RYVVh6b1dMVk0raUV6dUErOG5PbmJtTU9CZFJUbTF5eWlBcnlpZUR1?=
 =?utf-8?B?cjRycnpxY29uT0JmSWxHT01MWVFuVDltMVlnNXp3cnNyM0NYdlZMdnpPMldt?=
 =?utf-8?B?OHpDeGNYSzZkTEhBV0trdW1KN0RteGpaZUNjZUtld2NqTC9wZFVjWFhVOWpY?=
 =?utf-8?B?bU05eDNLQlhCR054WkdMTVNuN3RWWksraVJhL2lFTnEyL3hFNmdJdnVQYlU2?=
 =?utf-8?B?dEZQQ0xkZWFuRndRdDZyZklCTDA2d3NROER1R0VoeCtnWTZLQ2tPeWQvcHpy?=
 =?utf-8?B?MXowL1J5VzV4VldMWm9KcmtWSTZxaHBKMTVuby9Pbkx2MVArNmhnOTZmQkhF?=
 =?utf-8?B?R05Ub2dUQks2OWkzdmxteXB0bkEwVzUvc1ZtMDFDdXRITVJINGM0ejR4a05p?=
 =?utf-8?B?ckFBN3htaW1abUw4QTVGbFdubjlNUXVVQ1JndUNxMmtCUVJRbXRZZy9nRUdO?=
 =?utf-8?B?RTNCbWFRR0twTTAyeXVwWlc5TjJ5ZmtrNXlzaFhYcmxpeVJnYk53ZG9Qb1Bx?=
 =?utf-8?B?YzQrNEswV2liUTh1UThZcGdtVzNrNjhaRVBSaThXWjdSekVBc21iT0I4UVFs?=
 =?utf-8?Q?0EA7bu4eytrsg7dI3RDQAJI=3D?=
X-Microsoft-Antispam-Message-Info: uiuNWR8FtBXxfZzEu0+m5Fl9KWylItvvhUTR7Twy4xDera7602tlMwugyqVtaEHtmvV8arWj6zmwK4cFHoLBiaUdq9hid8VJ+Ei+UBVI/KGiELqlUYaMqpK/sw3Z2QMX3H+3YgodxWe2b0jOeR99QIBilA2bFnSUC+DWDe7ne92R+SxRuxKuEQNjl7o5lZLHiiOwZaYZhfaa1aMxV6f+NvxwsDHs7tdYUTXii2r4vmayKM5k9phHJZEnd679Zlj2J3QodrwUd+nouS3kusPl+vefkuHHs65GUZTo26jK/1uJAJGSi8RhlYFowQy3KE2eJHhDtjnQp+n1vZ1jtf3codH/PhrB6F1EmCPZtIoISb4=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;6:U9HrYedKaYsuDvyQATKyd+NL5YU4YbvSju5j4HaOacQOKYzRjzEZhhu1QrAeeGk3bHobl65rdJ8I2q3oOy62vQUCpaz2JwMFr9lKPAlL9al+56VOQR6IPHXtaL3L0Bexfeh4n0IAOWlMk13fLcD2J6ExH+euZhmk3x73adtXnqUSESvyN+oNDD2f48JCTgMiDXZrzuz2Lb3ZD8gQo/tGFTLDIUlPP+mFB7mB86YjrEJOS1O26zjb8e3AO3pHp31E931OySe4xi9rLAXwlToPsuO+w0BjU0j1FireAa4N8N2qAB1o2gz7IXsuUTStz2esxc5YfCGW9JD/enUjZWCRuUK2JlcFBeccPhubZ2QGJNkP7+/M6KbLpOdI/8vwT8/YO7Oz4q7unY9Zg5Vj+JXFi/B04xm5eUxIqvEvatm4bmhvLAOjpCqy95ONE+PWdq8UAG1/R0y1g4juj7JaPWxXQA==;5:oE9I/EhxsT9ZKHbjQA8RryQ+mGbnSiD7Lf2VWUd2A/u+184txykVRlq/2PvGGeVwr6r9ddIXmgTetqfzsrRpNemeOYhVXa19dWWJLiy779ALY5x1DbRFzK2j1ANsxGWo3lXdcwC6RfY9yk3zZRqSzpJ2EpkQhM4e3JhArQzZoiM=;7:LctPiYbysIdcMm2aJf+UJ/7aRDXEM2G+xSEyKQ7hTKoPJx5Agk388iFGXhWVGpEXsVrXp7sGWYIKjNaI5HSaKr+2XZnZkR5SuHO+7ijftuCjIph8mHqPpuyu4cYD7UYP1IgDrKUWZ9b9ExVy4n+Fx6I9tNEaZSrOJa77VJMIjXYgM9JmvKMOGIQUBFUkPWFwvN3cVRF6LkVGUFp0jMxmYvYPHNnTEC3VeB+mRm0r6EorU/OY2R3inF8NTYsb4g0l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 05:21:37.7849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26475336-2e48-402c-720a-08d5f05c2bb3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2018 6:49 PM, Alex G. wrote:
> 
> 
> On 07/18/2018 08:38 AM, Tal Gilboa wrote:
>> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>>> [+cc maintainers of drivers that already use pcie_print_link_status()
>>> and GPU folks]
> [snip]
>>>
>>>> +    /* Multi-function PCIe share the same link/status. */
>>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>>> +        return;
>>>> +
>>>> +    pcie_print_link_status(dev);
>>>> +}
>>
>> Is this function called by default for every PCIe device? What about 
>> VFs? We make an exception for them on our driver since a VF doesn't 
>> have access to the needed information in order to provide a meaningful 
>> message.
> 
> I'm assuming VF means virtual function. pcie_print_link_status() doesn't 
> care if it's passed a virtual function. It will try to do its job. 
> That's why I bail out three lines above, with 'dev->is_virtfn' check.
> 
> Alex

That's the point - we don't want to call pcie_print_link_status() for 
virtual functions. We make the distinction in our driver. If you want to 
change the code to call this function by default it shouldn't affect the 
current usage.
