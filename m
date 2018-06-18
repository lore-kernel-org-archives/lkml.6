Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF19C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2953F208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="mMYidHMi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="W/yTX68H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2953F208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935840AbeFRPLP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:11:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37206 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935681AbeFRPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:11:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IF3ZYE011753;
        Mon, 18 Jun 2018 08:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=6KPhu9HZqqZE4vFMVQkC2BKqv27ZUGA1oayiVhadroU=;
 b=mMYidHMiLo6aySn4l/j0OsKhVdoJk7kioxC3yDez4WvJWm0rINX5mi8qfQEP45uhTXFd
 j1nTW7rN4bSUcgp8nMkTuYajWGC+gmlt4zwxB8KrQUuOZ5f7wkFKzSaFpxrYF3g8CudL
 9A/Oh3yvQZwJcMAFIT9kGhPI60O3RvMl9jY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jpd63rbpy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Jun 2018 08:10:36 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 18 Jun 2018 11:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KPhu9HZqqZE4vFMVQkC2BKqv27ZUGA1oayiVhadroU=;
 b=W/yTX68HV/LLXf1R5vVzkznenEvGC6OJF7Q/VCt+hDzcOj/+wBuy0H5eGRVKjzC4uazMbBb+AuvvRA6Byp6lq7/C4GLkWzNwMTVUutIJABGgQuKU6T2ugtl0fyXUp4Xlwx3eTI1SYx35KnlF2fqTvB5dLDL7KYW3P7rdZAKYmaI=
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:200::4:846e)
 by BLUPR15MB0066.namprd15.prod.outlook.com (2a01:111:e400:50b8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 15:10:31 +0000
Subject: Re: perf tools: LIBCLANGLLVM=1 build broken with llvm 7/clang 6
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20180616122608.GM30043@kernel.org>
 <91a76633-54e4-984d-cb68-ca0445146b15@fb.com>
 <20180618143139.GA20477@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9dcfeab4-3324-1e26-74b5-4d182a47f834@fb.com>
Date:   Mon, 18 Jun 2018 08:10:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618143139.GA20477@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::4:846e]
X-ClientProxiedBy: MWHPR1601CA0002.namprd16.prod.outlook.com
 (2603:10b6:300:da::12) To BLUPR15MB0066.namprd15.prod.outlook.com
 (2a01:111:e400:50b8::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ddd2fe6-b599-4d26-da83-08d5d52da2e6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0066;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0066;3:dr1G6HIfI3Tg6+BewFjlj3GC9nqNAvicYSjJt0vAb5C49e5kbfmXKmZFzKcWBku4Ee+roj2EvoSMGJrlA+ajx+qjkFDk/CSVzZyCHxiq0hv+488ZyFIsPzJOGZSTQpU9U0vBR6sDF6WrZp8Ffb4DBVeL2ttpVT3zCKHzThRhkcufJda5ZE7DR8a7Yd/UaBaJj85FmsKr+gDQkpx7pDZurE2rxKL2AqRRVu6KMbTh2BUnMZWJ1SXn58I5K5ceXy66;25:XArobvb5AYEApWrn64dGdTnZYSoQDli+yiFB7mDK7CG0y/UYjcDmWRhjAC6JlwGwv+BPDKQfmWsQm61IiPKym5F+lcOPF4M8CdlLWc+1tlL3bht175bDrrdMl4rqWhXnfuiwDI5wukZNBw66MU2TXAlMMhr64zddrojLih37B+H6vSHFaN6qfE1V4sajpGlHNgGmnoFVJ5aURBHfIFyuoTASeBiSuScfNAY9zTwowfZwtG6mtEofGKogVNtas592v12/2mO4cgs4tgtx6mn1fqwTD5/NpCByosmeIAQaTu8R03lL0GnOxVmYa6szrkquXwkblM83hggI8pT8/CvYOg==;31:vyOfc8Prv4j07SefCufYQ+0cUE2OGCGaxyj1E9PZG46xwJoS1wt1UmzmlSrzF2RfIQibARnh4GyGpkMEBVIEs4VjaLW368fPkiizazatsLKmxDu2vtbVqkNL4VFaRMx3YwnTgd4L9Kp7X4/q+LbPW6VtoMgV9+kOv5Cnr3eOM5uoeI9QkT4Ya1fcKb9AJa/xH32eduJA+ryN5ZwG681lXIVbZmAn7p3EiW4W0aby2Wc=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0066:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0066;20:vgTrBjrd9x8TYVhi+StVavJpioE6zhWlXbL9iWR7+LTYS8IxGAM5jMS2IyJr3WsIqRFmd1WIA63wHE8fTO8kuiMSd3NJqBId0xAs5vClxnv5ZWr6APqap5vl2oUs/XC1AA9HES0UMYwJhjSp+nwaL+l82CZ0hHTjSAHO2plBjBAWznA6jA7nfl6lcl7aMTgoQC4O+rTYuYOtUaZzk1SaopsPPzm4aiCwyzj1EdhGVUvRMs4jcvHBCBVAR8nOXFWmDDzu6VdmI1nZwYeucpQiBYIidi8l0NqzbZh2HWaKxYYQEv5YQWax27hoNV+vLVuruC9Rfda3S3HSc10KXyYXn7WHkSdPl56QUTWDxvsyFowEDaNDD/ojOUcerKnxJNl+a5CxC8A1Z3Nc1v7ugBWDONi0hCg5TzzENHzYxCoVd6WV75DdPz6IRK0oVbh91UIA9UXqvg+xprDBG89ZdkQjJYoXnhqQmdFe5V4RU9BkN4LKZBVE0gbrEfgMUVt+kW9R;4:X9Nn0stFTBHv9UnF7V8oO6cV9tYv8NBttgJQpc3/sxQep6lBLbQHDBbmUaAHojufitWBWHZZtMBTzy/H8CY21QzuvOGnArr70oYc8srNM7AFWc38bDjK3Oo8K8nK6nVJsxz+IUOUTJIHUSwFTgGce+r/uFHG8igLvwUnWUhRnXPLKqwLhQfFrO3oyuoBAMhEBu9Qazz9H1CfclQHsYK2Q9f0huo8opplFfT3fr4ocyjUVZK1jyK1SS3gJdTfmyn5xuhZeFDX3GCzpk46ZxARNw==
X-Microsoft-Antispam-PRVS: <BLUPR15MB0066FF4493C218CFECAC3EA6D3710@BLUPR15MB0066.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0066;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0066;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(6246003)(7736002)(76176011)(11346002)(52116002)(23676004)(52146003)(2486003)(52396003)(6666003)(53936002)(4326008)(5660300001)(68736007)(25786009)(65826007)(6916009)(305945005)(8936002)(67846002)(2870700001)(106356001)(966005)(81156014)(8676002)(478600001)(81166006)(36756003)(54906003)(58126008)(2616005)(16526019)(186003)(386003)(316002)(6506007)(53546011)(486006)(476003)(446003)(47776003)(65806001)(65956001)(105586002)(86362001)(97736004)(46003)(6306002)(6512007)(229853002)(31696002)(6116002)(6486002)(2906002)(64126003)(50466002)(31686004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0066;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjE1TUIwMDY2OzIzOkpnMERRdzh5UHhaamQ0ZUVYSHRPVUZYekRO?=
 =?utf-8?B?WDBlSjloazUyRDNuQndxSUZPRnlrRGZIUnAzMGI4eGE2Uml1VS96eVBIa09N?=
 =?utf-8?B?TGZjTC9Pai9ldTRLZG5kQmFFeGZhbjVHMGtFdkdGYmVhb1MwM0MxeGwxVjhp?=
 =?utf-8?B?U3FRVmVXMktobHVlVXhybnliRkhSN0Zmc2NCNktUcTRBK1ZNcU13aDdoRFFz?=
 =?utf-8?B?b0lSMk1BQnRHdkJXTnJNUWlnUDJGbWVFa0gya2JSN1F0TUdGZ1dPL0Fwc0pF?=
 =?utf-8?B?T01pTkM5ejkvTWM2SVNSRzJOWUZyN3NNbnpxMVJrRStaSTh2eFJKbnVlUjJZ?=
 =?utf-8?B?TzMvakJrRkNZTEdxMTZUNmV6cXd4YitXVjIrd1hhOW9BNGZyWDIzNHNpd0lC?=
 =?utf-8?B?VlhDTUZiZDF0eDhWMUVobzRTcVAyaEpLM3pLYmVOaG41L1VoUThPMkFpNmxu?=
 =?utf-8?B?SFJybmtnbVRSdDJDZlZGUTVjZExxcXJjV3M3LzRUNGZMUlY2dldLUXk3WDlk?=
 =?utf-8?B?dUJ4WGZXYi9MZ3V6bWdXcS8xUlp1S0lDTEpQYjFGT2ZpTkpRZ3lYYzZzb1M4?=
 =?utf-8?B?YUZjVWhlaVFhTGpUaDRQQVU1QmVnRS9JVldkM0lWclcyb1JRQlFtQkdSK21F?=
 =?utf-8?B?KzJJZ0xqaDA4dFM4MTVEMHNEMTQwTzRET2NMVWFzaGNGeFY0ZnVjbDRpcW1G?=
 =?utf-8?B?NUJzS3BzRi9rNjhDQ1BvSmM1M0tFWkcvZjl4cFNlSlhpVVJYTTY5TGwrL04v?=
 =?utf-8?B?OGxwdG80TFNIYkNvbHlnY2JyMmJrMndjMXdRSXlDeHY4dTFBZ1NWOGRaNzBp?=
 =?utf-8?B?Q3BrNEdrY1JQb0JndlVpNVhKaGtqVWplY3VqZklKTUErUnUxekNia20yN3RU?=
 =?utf-8?B?ZXFqSHRORktnTzEwUHBUa1ZLRjgzbWpRRFFTeVhuMDk3Mm5pbEt5eXptMU9D?=
 =?utf-8?B?b2RQelcydysvKzVNZHJyM24yaytwQWlVcldVMEpiL21MMGJGUk1vaS9KMVJj?=
 =?utf-8?B?TERoWVU5NHBkWXplcTJnS1BUM0JDNjVwSWticW5ML2g1eHVDOURZWDdhbkdN?=
 =?utf-8?B?NUIwNFlSc1UvanltNDJ2QlBua0xYRWYrbUxPZHJyYkhWTFRRbGh3RTFqU0Zk?=
 =?utf-8?B?ZWlsSHA2d3RsZTNCNWZRWjNwTTFaOWxOMkh3TjgxY1lSdjc0WDIzSXlVSnVQ?=
 =?utf-8?B?TXpXVGlIWjl4Q2VicVVReWExakRDZExUQkU0YXVPMjlZSnRkSzJSdXNUdFpi?=
 =?utf-8?B?SThWWDBiczZ1cDF6aGJ5ZkZaZ2QyTTN5MVNHRXhkNFlhcXIvc2gzMFR2T05M?=
 =?utf-8?B?WWdtbitIVHRwQjYveENuVVZRWmtSNFJuSFEwTnB3N3l5cGFWU1FuVFZpeEN3?=
 =?utf-8?B?WnUzNGRGakNIUHJXL3VNSk1kQVJjemRLczYzWVhSR0NleDJvUGg4UXBsbU1H?=
 =?utf-8?B?bnlSV3hocHlLREJFOElCd0M5bTdZSE4wNzl1Z0pqSGVRWmhVWEU5MStJVGVp?=
 =?utf-8?B?L0ExdUFSU1Blc3FEREJ0SzlydEFjUzdHTjVFMERzOWFBUmRQYnVrdFNReDNK?=
 =?utf-8?B?VFBrSnRSdjh4c1lobEliUGgvbVBnN3lsallza2tIMC9jbi9hU2haM2p2OHZq?=
 =?utf-8?B?dVdJaDM5Y0dTMWtnUkJwRHRjUUhVc2NiTWtoSDV5dWpoT1l1eGpXRTlTQ0hz?=
 =?utf-8?B?dnJMckZwQmJ4RFUybURNc3M0bnVWM1pzWEUrMWVXZ0hGVFBuOVBqQys4c2RP?=
 =?utf-8?B?Ykx2elhFNHQ0cmc2MmltZzRrMnhPbndSelJ5aGlvc2NPRzNWenFJZ2xpZHVn?=
 =?utf-8?B?aENkTk5DeCs2VVNKL084a3htRTRRcFRlMmxHMlRjN0d4d0oxekF1TEovMC9q?=
 =?utf-8?B?eVgwSjFKd3BtYXVUbHpWZDFYdTZIbm5ZdFA5Tmt5SWxudUZQbldock1zaWdO?=
 =?utf-8?B?WmloTGYvKzBOS1dGREZMWlpOcS9uaExXYzlTUGNjS1JtSW9yUUg0QUlWai9L?=
 =?utf-8?Q?RF8G4y?=
X-Microsoft-Antispam-Message-Info: b6c7v6gvD/bxhtDrMOxVjGXSAkBqxfYroDhowoQHzZCxCgTSOXMqPMKHQu/mD2Kkx9LC5cEYdT15EX1KYY/qm1XnNNvxSy+a60GZg6xo6tPz4Jis4x0KPuRRR4t72dQmOhY+Wtf8ZWLNgRJ6RqFvMLrFNFdZNtvsqX8BLVjZdTTSd6RayTrhmUWrWcZ+o7naS1Xc+oRwew9TSt9Njt6S5FABpx0LQEkqeiYdo3bnKS66FdkiUVZwq79LS1viJCplXRrGGh7z7HTZm58n9O0QZNrJzKg7O3KuFaP1p1Nh8XKB46ABVxaDh83tabp8d6QrZG9WNSoEYt6Khw4GRabsgQ==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0066;6:gzbhN1MjyUHPMluTPXhJNUMxe36AD25LZG5BGI5UcstQG5zyLtk8+RyNFgbpdhHe7Crv3Fno/hplPQOp+DzOKNwfue1GUMgBkf3UhHCblwKPnxN/iEzeOJOn67lPgYTVNPqZI/lKD1J8AzJFQefJEW+4VKayKGML7OY8wIXwiZVA2urmDPLaLbDDrbHKY90pmrmF+IWDDzO06BwYiLLpHZDG8UYmviD8djB1+ILeIIoMfxfSVydKDdWalaDCIV3vHwAMMhCRPMNQHEQD/ieXi4mKdvZqd8drL87yUtPFMCgWU8VDyr3jzE5QuA8HlxkFk6+zD7jFQ0XLgxhx0ITPOh06W7kqjsu3c3n82RdwcP/6Sbm7Vj4Wb1kyOMBZqlfkmP6VXIDGRkzMIWNH8+r/88Zd/m0F2fQeLG6AtPM5UWmfWLP/pzIeTV2h9x8qrHeXtvpVGXmbo/ymoT1S0TV/1g==;5:OarpmM+kopJK2qzIrfI+Z7PZ8HIbbf93H3FG1WdZNvOEupXxVW/Nk0XdGEdJA+ztYi8oEsa374zSbYl6tenP6Q13+QoxkhHsV5UsbJ8EHHzzK13atQo5hiND2N4mCSX4+gYvZpDgqbzPfUFVzP/NDE5KRE8DSt86UBZMgmE3F8o=;24:c5yMf85BjXX+ULE6sza900ecWgDZ6Pd96BDgvNILVi7zUwMEXDD+zAJG6YOxRcFe4itpth30MUFujBtf3PSSbr/OC7MGafUCYGGuFk3Vres=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0066;7:T+6CZGzQGdw1zsMIVrg79bZIMcORdBkWma842e/B+KOIKnP9UYmK5EmZF9gknO2gLe8Nt9BceFNpQiEZTBHScN+C5agqt0vo5uiQ4ZsoSt+PUIipU8ynIL8oill9tPpHSkNJPtQYqr2LUjBGkRS/Muq34hXBBx40nzDVfzY9ecBWeLlz0OBsxtlYr0Z2Qja8k4vKmb+9bVDReaaC8kZrXIv+GzjzV/kgl7nuzAFF7MhfBde8SvXZkv+x4bCpLITd;20:fJu6mVghoX8RO02XskksvKxYAQA7yzL7tVtp9L/0AmVXUd1+RqgCLI5r/BKG6qO4UUSlVd595UT1qG1jyceZXg6bES072Ug6Sivv5WFpDvIRqavXdD5D9Gl8hUUumUNl0regtMaE/sGj//pJoDrBl4nDsC6v4dRKFWOq9TWQL+g=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 15:10:31.5763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddd2fe6-b599-4d26-da83-08d5d52da2e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0066
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/18 7:31 AM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jun 16, 2018 at 10:20:21AM -0700, Yonghong Song escreveu:
>>
>>
>> On 6/16/18 5:26 AM, Arnaldo Carvalho de Melo wrote:
>>> Hi Wang, Yogong,
>>>
>>> 	While reviewing the BTF patches for pahole, I updated llvm/clang
>>> to HEAD and then building perf with clang embedded I noticed this, will
>>> investigate, posting here to document the regression, maybe this is
>>> something you came across in other scenario:
>>>
>>>    $ make LIBCLANGLLVM=1 -C tools/perf/
>>>    <SNIP>
>>>     CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
>>> util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::SmallVectorImpl<char> > perf::getBPFObjectFromModule(llvm::Module*)’:
>>> util/c++/clang.cpp:150:43: error: no matching function for call to ‘llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManager&, llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)’
>>>                TargetMachine::CGFT_ObjectFile)) {
>>>                                              ^
>>> In file included from util/c++/clang.cpp:25:0:
>>> /usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate: virtual bool llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&, llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bool, llvm::MachineModuleInfo*)
>>>      virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_stream &,
>>>                   ^~~~~~~~~~~~~~~~~~~
>>> /usr/local/include/llvm/Target/TargetMachine.h:254:16: note:   candidate expects 6 arguments, 3 provided
>>> mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such file or directory
>>> make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101: /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
>>> make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] Error 2
>>> make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
>>> make[5]: *** Waiting for unfinished jobs....
>>>     CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o
>>
>> There is an interface change in llvm 7.0 (trunk) for function
>> llvm::TargetMachine::addPassesToEmitFile. The following patch
>> should fix the problem.
> 
> Please submit it, I just tested and the the build finishes Ok.

The formal patch is here:
https://lkml.org/lkml/2018/6/16/92

> 
> - Arnaldo
>   
>> -bash-4.2$ git diff
>> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
>> index bf31cea..11dee58 100644
>> --- a/tools/perf/util/c++/clang.cpp
>> +++ b/tools/perf/util/c++/clang.cpp
>> @@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
>>          raw_svector_ostream ostream(*Buffer);
>>
>>          legacy::PassManager PM;
>> -       if (TargetMachine->addPassesToEmitFile(PM, ostream,
>> - TargetMachine::CGFT_ObjectFile)) {
>> +       bool NotAdded;
>> +#if CLANG_VERSION_MAJOR < 7
>> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
>> + TargetMachine::CGFT_ObjectFile);
>> +#else
>> +       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
>> + TargetMachine::CGFT_ObjectFile);
>> +#endif
>> +       if (!NotAdded) {
>>                  llvm::errs() << "TargetMachine can't emit a file of this
>> type\n";
>>                  return
>> std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
>>          }
>> -bash-4.2$
>>
>> Will submit a formal patch soon.
>>
>>>
>>> - Arnaldo
>>>
