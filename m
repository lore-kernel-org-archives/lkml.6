Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A37AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE17F21779
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eJgIgbfr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bDll2gS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE17F21779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeHUUoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:44:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbeHUUoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:44:04 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LHCC6Q013163;
        Tue, 21 Aug 2018 10:22:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=UfOO88VFYUHZfvjvDQfB3uBi58xZzTWE7jza6HCXBYc=;
 b=eJgIgbfr0w8mGNf7Cphz2LSDre3f1w5agcoYAmewP6Y9g/X7T3kbDlmHrq3b/4RDdnxp
 +jG3E0GNpLa+fL1sBdSVKXRDanpiu6rlH3MeMcnS3TzngyYL80k61VVNA/e6dVvLYeV7
 8msVEKPAc8I7tsdwWrkwDP0+iQ6Ri2aEHl4= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2m0mwe8jbp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 10:22:50 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 13:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfOO88VFYUHZfvjvDQfB3uBi58xZzTWE7jza6HCXBYc=;
 b=bDll2gS1jfRV0ycHIIXgU9m9xnFlzb6jV9gF8FhzI96/ytDrFjf+X+HTP/vHHcoT3JVieM2KuxehFZ7pIdIrwuh1uthQQxH+uh5YLriI3sJ54AgwL0ROf1r76vM5RXLppKBIwgyGWjEImVVCeY4MoAr6165lyjd+gGphrYFslk0=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:6ac8) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Tue, 21 Aug
 2018 17:22:44 +0000
Date:   Tue, 21 Aug 2018 10:22:39 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Michal Hocko <mhocko@kernel.org>, <luto@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 1/2] mm: rework memcg kernel stack accounting
Message-ID: <20180821172236.GA27058@tower.DHCP.thefacebook.com>
References: <20180815003620.15678-1-guro@fb.com>
 <20180815163923.GA28953@cmpxchg.org>
 <20180815165513.GA26330@castle.DHCP.thefacebook.com>
 <2393E780-2B97-4BEE-8374-8E9E5249E5AD@amacapital.net>
 <20180815172557.GC26330@castle.DHCP.thefacebook.com>
 <CALvZod7TDLtr-DgqgW_0tOKei_54U1JHThpgLKr9_ObaqcC3MA@mail.gmail.com>
 <19CD1E5B-CB86-493A-8BA6-7389E36291B4@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19CD1E5B-CB86-493A-8BA6-7389E36291B4@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:6ac8]
X-ClientProxiedBy: MWHPR0201CA0089.namprd02.prod.outlook.com
 (2603:10b6:301:75::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dfec221-bd01-4190-ec35-08d6078ab540
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:yH2JZOUL8fw5WNajRUfYfxOARP4uuDjjTW6DUhWy/O2IBaHI2w+Te9j3T3HOjp5MAbvolZiZV3PHPuejEe+eW4w7K3v6nanJ/2VDleBCMEj6//m8waN/NE9J3MEcXRDa19jrFIgxeLB81QaiGzv5RgehbsBBsw8jyS5AJbZj45sTLTObHy9DS1aZowLzpXr3xxt9vNgHs/gqCDPYpOmD3rauKp2bW3xoY8urSnUUX/G4BOh7WhkSt8Hukldzfxkt;25:4Ya09JdCoJYfQUNB0YUelJ2BwUTIK6x8XXfDVbm5zleQm+pNTM6cEfFsuVA15liQbRmtTEm2CEHQhD3+vY6IfzitnosiawRMXexbBBsQWDiiayfd5oiPpV4yMDs0HjtQoPbftw+vakElA4HDrWUJmKiBDgr65DsJ/aCYJgL7q9iANb2PihPVqbRFK7Z4TocrsPgD9z2WHgDJGcEL4t7nlEkO+RHHSF+EqC7cdUJ8lvE3QVGX+wpRdy05EQu9V8z0ZnAIgz2l8UGRg5hg2blCz8MxS5mKNoLBn8ljkdwbUfEBmgPkLmcr6LrvcP+ulq2c7pn0nYVQrakMxZksvqvC6A==;31:WjOwXXye+um9Do5eOOcvpN+u8PHXYIWy/2wBvMRqXlWKiJxDCSe3aOHF9A707R7a+4Xcw9+3rkCVFjZ+KZm7C9ldGd6CFbpV/wzEDjQAgUpq/1kJwL0CWGJ9gMt0GDVARWorg3Qk9Mz+rWY+JDtVKMLvQNbAgeByLfgV/W9VbKA1ww/LU/JoUNVaI87KfSO7RXmitZ6+M3eHaZKYtZlPNn4l8ti+XndOypNqcqUts/8=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Zwx939V2L1iEhl8jeuohVE66Jx9HWkD8voAsAbzLkWYqs9d39yr625NRpdq6wWdaaXecWnDmSPK0RcgIuoED/qK6XacRQ56uO6P6O7LRE5q1rtSRSScar+6i4E9tQ3orhqJBRWwWS/Uv3tCXUWy8CxEanbYARRp0Y3JEnLCxRIeM+BMbxh6LVIxBa6nuDkUbOfbXcob/bTCSrvhhi16Ip/QSCuAUbnuWMjsLpCpfE7N6kMbDnDBZdS7282mn0nNaAtAd2PguSOWTmJBr+1KWMbTQTSUv2jHYj8a7WcIedBQcENMH/Hfz0u39qCNpgeF3SlmZogUPyh24Rh/Df17acK73zHHcqT1hDAuBmxatXcZDN57f66FXKq6o8RN4Az+rkF30f+7dOnmY82AFxlJbY3JNPR9TZHBSg5Nolu4inTAgOsZA8LIQOR+9VEaeMZML01vNqJeXogmzVWd8apHvbIFzJfze/p/PBWXBPId4VUZLxYz7fihaNbrFCfB3aMZE;4:Df+u9gffJL5Plb0kP7Y7nY1cq/2CSvxu8F8ApaN6vA6wtPgCXC78NaRtD9d2qdEfAFAZ3pfcewC+yw8LuFmmAcgMHTyKIHOlhjHZ3piAX+2hpc8Hun3Vk2fXC3q0H5Emo8vv8daYVJ2G9Tlppbc7R/fptpBc9VQSPcvMKKCeiiH/k4apJYjqXiKz1EpER3+Hzvfxh5zqezj239Ufcog8lPBfHX8am+pYvFTSoce4kc/Hz838AM7o9M53Fl4DHIWSGqTU6ZM0vyFpl1KkdnspM6ibzrD49ftM+NNNIN0cDA51q4kY8xIA5PxAX7pX7p+bg+/GrxMDGNEpxlpPoUPaBAkOifn0CpSEq6+YbbKjiWdOOkpNhiCu8dg59jjhjMQ3
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167BF169A4D5CBCBBCBFF74BE310@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(52314003)(189003)(199004)(52116002)(6506007)(386003)(81166006)(25786009)(217873002)(16526019)(53546011)(97736004)(15650500001)(186003)(478600001)(86362001)(9686003)(14444005)(47776003)(46003)(11346002)(55016002)(8936002)(476003)(53936002)(81156014)(446003)(486006)(93886005)(6666003)(8676002)(4326008)(5660300001)(6916009)(6246003)(7736002)(105586002)(52396003)(39060400002)(68736007)(305945005)(58126008)(7696005)(6116002)(316002)(76176011)(229853002)(2486003)(106356001)(2906002)(50466002)(33656002)(54906003)(1076002)(2870700001)(23676004)(52146003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjE1TUIwMTY3OzIzOjhvR05vOXU2Q0dSRUVnUG1MaFhDYlNyR0hH?=
 =?utf-8?B?dDU3Y1B2VFNtQzZ2elRJR1JpekpadVpQYlFuT1M2Z29PNDBZY0lTZmpUb3FM?=
 =?utf-8?B?cVZSNFozbzVTN1R4N1hYdnlLRjF2c3VTRk9CM2w2cjdFWWhHMDIvWHRIbmxW?=
 =?utf-8?B?MW1keS9uRmovZWZxY0tIK2FOL2FhMkk2NzZRZk91TUhBaWUvVlFCYUd3djlw?=
 =?utf-8?B?UkVON0F3N1lsTXVEanZCaVcxWHk1eVpHRWlvYUZwUVJCRW9kVEozMnJLL2xz?=
 =?utf-8?B?cFVNRForalVrelpSQWxYRFlENkZpTFNqNUszenFsUUE5K01rclRuaDEvTGZZ?=
 =?utf-8?B?OGZNQzZ2eTFRNHhpVy8yTERod2Rabmhmc2pZWktrSlV4cHRCZExyMmgyTEh6?=
 =?utf-8?B?RldpRzg2NVpJOVJGVnZtK2ZkeExQMHFlSXlzeTZVTDllMXZNc25LdE9oVnY4?=
 =?utf-8?B?VThPMVY0emRtaUdMWTZzZWpQQVZvRUc2NkQzbHllTkNFRDlNTUlvdkJVV2tO?=
 =?utf-8?B?bTJOQXdCT2dJK09zR2JBUWNHRi9WeTI3TEtLMzBUUnlaOHNMaFhzRnZBT20z?=
 =?utf-8?B?WDNONE92UFFudVdyT0p5UmJEcnJWYUNheHpMbFMydkFHMWN5WXRqK3dYKzRz?=
 =?utf-8?B?TDBQZGxlamgwYVpNdXd4K3FvcDZZcHlOUnoyeHNZQnFtSVZDVDlBMWJ3UnRO?=
 =?utf-8?B?MndtRG1PT0dOUmNqZGlXQlpwSkoxeDBDMzJ6TmdMcUxnYjZtQy9lcXBZbzVF?=
 =?utf-8?B?Slp2L3B2RlBtcjhReUI2QWQzQ0FKZEhOaWpjSXJ1MEN3SW1TaUhnK2hheUdT?=
 =?utf-8?B?cmpkT0x1RFAvcmNLZ281MWk3cDBaU2ltWmRVQmJsWS8zNm9wbFRmWS9pcjhj?=
 =?utf-8?B?a3ZidXJWV084Qmc1THRudWtoS0IzT0hXcEwza0pkOFhOS2hRNXBBb3hzNTh1?=
 =?utf-8?B?ZVQ5a0c2N1FDcjJUbENoV2pXRGlyWkpJUVRKRFMzSXp5MFphMXZyMklxVDl4?=
 =?utf-8?B?MjJnTDRXNloyTC8vSmsxZFg1cFBhOWhHKzZvM056TlhDYWVQbkk1ek53N0Jh?=
 =?utf-8?B?ZFdqRnJtM3pNZVRlaVMzRjAxS2ZRb0p6TWVkaEVoZFA2VW5CMXk5VUU1OUVO?=
 =?utf-8?B?WklsdVVKSjlrMWR2K3VaVkJLMmJYY2VaVGJjeHhNMS9PRDRDcUdwdXByM2sz?=
 =?utf-8?B?aDJXam9Iek1CU001N1F0RkhNaHQ5VmFScXdmS3ZrOXJCckVzKzQ5YzJNN05n?=
 =?utf-8?B?MXJocFAwRXNxdlFhOHFiMHRidEprZ0JzZmM1TGRON2RpMEFFVDlNSnAyV3Vu?=
 =?utf-8?B?MFhSaDQ1bVgxNjc0QTRUTVp0ZWxUZzNHSTBnZ0RXVmk0R2NmZ0xCNzBmcnRv?=
 =?utf-8?B?SXU2YWVLSkhVa3ZkY0cwelR3Vk1CR0lVNTY1K1VaUmZwc1VyckVRWHEzMUJk?=
 =?utf-8?B?VXNkQXR1Vko1NCtLRmhUTFdYdENtUFVnR2VNQ05SUnlqTVhOTkJ1cmYzVGl0?=
 =?utf-8?B?YzJrU0FKSnljWFpVdEFGMVhOKy9WVmhUY2U5YmtpZlp1U1pIUmVjV3dObEZq?=
 =?utf-8?B?STQyaDdld0sybFA1eW0wWURBK2tWQzVyL1B6QytZSE1GaDc2K3B3NlkrNTBl?=
 =?utf-8?B?ejBMRzM1dEN3bVBCVFkzUkh5UVVOSFMvMjNoemQ5Rmd6L3hvdWwvL0x4M1BF?=
 =?utf-8?B?VmNLQW5KSzlIQkw1RlQwb21WZWR1MUZGbjVsMmw0M0xseFFTYmoyNmptMXU0?=
 =?utf-8?B?RU4yMzlZQmZsaVduR0VuUFB5YmJZWUM0OEVGNEt5QUFZVUkzK0tPOHRJZkRO?=
 =?utf-8?B?aFZPcDNFTmRKdEpOMGtPN0NSMHdrbGYzQk1RVXFwTG1JTWFFZ2s5aGRyZVIy?=
 =?utf-8?B?eTBSbCtWS3hmcXNPNlNHdHJ3bFVMSU9FUDJLSmJZcDV4YnE5YlY3bEpaSnZy?=
 =?utf-8?Q?Zaeg8cpHMSXo95Wc+1vqvfIOvT5A64=3D?=
X-Microsoft-Antispam-Message-Info: HLm9k1q7EA8Lsjl5uCxIbpyizwrK/5ihmyuDq3XicQw87KpFNeFrgtR/cjyGVy5ToE9ngz8BNQECb6mGZ8LALZY10vdsHdjyGZvRBLtoTjpth7Wk694tRifCuEPwfS7NGOHT8E5ktQoLD3UMhOU3u9N5ilnZBHGSF4V/FQsS3NnFwjcqM8yzSIT4wKhXpfuW1BNn0N5RjQ8gNh2Xc8PTvEYufCEf7CEfcWcZa9AFuHkkI3yWwKBmAwLMxP1rP53M7qFw4hzl1Ui2ZHpnO3qAVPa/u6JjMUu7RsALQGkQjSS0LFYAl7V5k0cM/1BoMLa/nbyuUPAn2DCTaTPodZSauQPp1KyAFhaQ0qeCecJ/5U4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:oAdY7JfQQbRDhvFkqyvWVzFCgujXbIqu4h+pWsJHrqqa4zJLPNM+r0MMeymTN2Ea6ojr3PHRCINj4Gzu0t06E8n6VU+4ST47/7kTk5unyvjHUL+Jk2lSRv0yKC2OQxcil49tE+af9XKapnimrFgbB+GocDSe0xZUQBenTxflHgdnQqISwEFME76pNqxiknbpT/R6+NOPn/3Y6v+yRP0CUgCxPxh/mT3yymwH768FuaS9HBr0pq1u0heLIZfhWEHyjt6HfE8QhMuv0RCpirK+02NbxRQRYVXI0v8X1f4J829/oX85bqcrr25oN7NpqmPpSRQAuUDBPBOtQAe/R65mHePUDpWfBc1QCKO0STSFjpy0RFV93gzmJ2adUMWuGeJlG67GTjDSwPtH8OS+xMvii7T6slyZhb++EfwBINK1/LoxgzPTUja9oH4TeVj1vPRrMBdW2nwjHA6btOWFX8rXqg==;5:m7fo4yeIO5ijuft5D1N6rbH3ymMQTqRz8B+obYIBlGYBZgGfjz7S/eVd2uGB+QO7IzpUb8Mo32oE2H2pRlkuKVBDCiLfx1eASAeAVFTTPtLfEimaeX7qvoi1f9x5WoazW9GavOVxUbdo03eKLcEYWAKXv9QQU9YjmJcrZAKIXxg=;7:xL0cG2XvyAY6oUDGauAD17v1YCQBq+HTpQBYX1y80TR34HtqWhL7USJr9UhYOtibguHsZQSVc1D8vkSKwLnz/ITxIy6zT+GrSA14b6jayHrf6NYjLj2yv+h2rok5NPNGEi6OV7eI8si4OWMJHJWh901CckW/A+g+1Mt17MfK6RnYtLApEFZJ9OEqqbRM+KhRjzWoOv5fD5Quzt+EvfK6NMnv8EF3XgLuSvlbse+0tdFUAkn7x9QlSIHkugRt7XEL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:QBqfnS+1ikBls/okvHnK2CbuiigMkr6Jc3oNPFiy9bpg6ux5rEhbdbjGLnve5l+B84HPoi3kWTHVN+ay6MauFWvfVPzig3i3O+GnzGatDaRd9xRQHuGk0FcxZHxUaDVW4wmLMm9LkoHdEkj5EG9Lc9Z3NseKV9Pxsl+AK9Kphls=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 17:22:44.0753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfec221-bd01-4190-ec35-08d6078ab540
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:37:28AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Aug 15, 2018, at 10:32 AM, Shakeel Butt <shakeelb@google.com> wrote:
> > 
> >> On Wed, Aug 15, 2018 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
> >> 
> >>> On Wed, Aug 15, 2018 at 10:12:42AM -0700, Andy Lutomirski wrote:
> >>> 
> >>> 
> >>>>> On Aug 15, 2018, at 9:55 AM, Roman Gushchin <guro@fb.com> wrote:
> >>>>> 
> >>>>>> On Wed, Aug 15, 2018 at 12:39:23PM -0400, Johannes Weiner wrote:
> >>>>>> On Tue, Aug 14, 2018 at 05:36:19PM -0700, Roman Gushchin wrote:
> >>>>>> @@ -224,9 +224,14 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >>>>>>       return s->addr;
> >>>>>>   }
> >>>>>> 
> >>>>>> +    /*
> >>>>>> +     * Allocated stacks are cached and later reused by new threads,
> >>>>>> +     * so memcg accounting is performed manually on assigning/releasing
> >>>>>> +     * stacks to tasks. Drop __GFP_ACCOUNT.
> >>>>>> +     */
> >>>>>>   stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
> >>>>>>                    VMALLOC_START, VMALLOC_END,
> >>>>>> -                     THREADINFO_GFP,
> >>>>>> +                     THREADINFO_GFP & ~__GFP_ACCOUNT,
> >>>>>>                    PAGE_KERNEL,
> >>>>>>                    0, node, __builtin_return_address(0));
> >>>>>> 
> >>>>>> @@ -246,12 +251,41 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
> >>>>>> #endif
> >>>>>> }
> >>>>>> 
> >>>>>> +static void memcg_charge_kernel_stack(struct task_struct *tsk)
> >>>>>> +{
> >>>>>> +#ifdef CONFIG_VMAP_STACK
> >>>>>> +    struct vm_struct *vm = task_stack_vm_area(tsk);
> >>>>>> +
> >>>>>> +    if (vm) {
> >>>>>> +        int i;
> >>>>>> +
> >>>>>> +        for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
> >>>>>> +            memcg_kmem_charge(vm->pages[i], __GFP_NOFAIL,
> >>>>>> +                      compound_order(vm->pages[i]));
> >>>>>> +
> >>>>>> +        /* All stack pages belong to the same memcg. */
> >>>>>> +        mod_memcg_page_state(vm->pages[0], MEMCG_KERNEL_STACK_KB,
> >>>>>> +                     THREAD_SIZE / 1024);
> >>>>>> +    }
> >>>>>> +#endif
> >>>>>> +}
> >>>>> 
> >>>>> Before this change, the memory limit can fail the fork, but afterwards
> >>>>> fork() can grow memory consumption unimpeded by the cgroup settings.
> >>>>> 
> >>>>> Can we continue to use try_charge() here and fail the fork?
> >>>> 
> >>>> We can, but I'm not convinced we should.
> >>>> 
> >>>> Kernel stack is relatively small, and it's already allocated at this point.
> >>>> So IMO exceeding the memcg limit for 1-2 pages isn't worse than
> >>>> adding complexity and handle this case (e.g. uncharge partially
> >>>> charged stack). Do you have an example, when it does matter?
> >>> 
> >>> What bounds it to just a few pages?  Couldn’t there be lots of forks in flight that all hit this path?  It’s unlikely, and there are surely easier DoS vectors, but still.
> >> 
> >> Because any following memcg-aware allocation will fail.
> >> There is also the pid cgroup controlled which can be used to limit the number
> >> of forks.
> >> 
> >> Anyway, I'm ok to handle the this case and fail fork,
> >> if you think it does matter.
> > 
> > Roman, before adding more changes do benchmark this. Maybe disabling
> > the stack caching for CONFIG_MEMCG is much cleaner.
> > 
> > 
> 
> Unless memcg accounting is colossally slow, the caching should be left on. vmalloc() isn’t inherently slow, but vfree() is, since we need to do a global broadcast TLB flush after enough vfree() calls.

It's not.

BTW, is the test, which you used to measure the performance
gains of stack caching, available publicly?

Thanks!
