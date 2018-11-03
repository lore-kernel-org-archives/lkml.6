Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EDC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11F220833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="jAzkK/Oh";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CRslB16f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11F220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeKDDEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40028 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727497AbeKDDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:30 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3Hmlih013639;
        Sat, 3 Nov 2018 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TdYzYZmkDKg8kTSZta+uAt9z2Ez2mN073aS76CPCxRY=;
 b=jAzkK/OhqF7vKh1X4KcA9CO2tfTvpxE29BPe1eXdSSTAWfUHkd7z0ClvAOE+ExlZbAiZ
 6HKKpQPs0PKUHrlaRv0O4Fv0lXcl+YR67mG6tuwhU+H9aeQ9yAPD12AQ4fceIkLOxzTq
 9gMiibRMBP2GFh+TrsFdN94m6xjtzRdZ1Xggphd4IEOYO5vg7D4Da/C+EPDfvbNL3HBO
 LHNvX0gqJ3k1YXauiwkRRqzwrWfsGpLsNb99teg01U+5vCoFz1EzI7IvpWPlNXHIXBSJ
 SjXRopwM14eFxA32/hMjf6xWLlGJTZgul/h6K55oIk5zzeQxAh08xFXkc4TwJNxA8Tyi bQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp0053.outbound.protection.outlook.com [216.32.181.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdYzYZmkDKg8kTSZta+uAt9z2Ez2mN073aS76CPCxRY=;
 b=CRslB16fJDDIJaQmf/VtncI0ZMqWllwKbw4cr7VUu4oHWhiYG3jaYYWqgBsQ7oH/64ITeB7HpJ+9ts2Imer5KL38lm4xeiVANteYySnAH7hPv2VPXsI9zFCXj3siZed/hZbNgUwX3HFfn754YDtqwPP9qm6vT8pmv2ApXZk4Z3Y=
Received: from BYAPR07CA0048.namprd07.prod.outlook.com (2603:10b6:a03:60::25)
 by BY1PR0701MB1864.namprd07.prod.outlook.com (2a01:111:e400:51ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.27; Sat, 3 Nov
 2018 17:52:18 +0000
Received: from CO1NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0048.outlook.office365.com
 (2603:10b6:a03:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:17 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT003.mail.protection.outlook.com (10.152.96.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 17:52:17 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqFiG009411
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:16 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:21 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:21 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x1000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9Wb006352;
        Sat, 3 Nov 2018 17:52:09 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3Hq9Lt006350;
        Sat, 3 Nov 2018 17:52:09 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 03/14] usb:cdns3: Driver initialization code.
Date:   Sat, 3 Nov 2018 17:51:16 +0000
Message-ID: <1541267487-3664-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(2980300002)(36092001)(189003)(199004)(6916009)(26005)(446003)(11346002)(126002)(2616005)(476003)(26826003)(87636003)(426003)(4720700003)(51416003)(8676002)(36756003)(76176011)(54906003)(14444005)(305945005)(186003)(7636002)(107886003)(5660300001)(105596002)(217873002)(478600001)(336012)(486006)(4744004)(16586007)(106466001)(356004)(47776003)(6666004)(42186006)(316002)(2906002)(48376002)(2351001)(50226002)(50466002)(8936002)(86362001)(575784001)(4326008)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1864;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT003;1:weWked61/9t5v76jf1NEoQ3xG9zIVhhLzs8mz1qfCpZlIRAl/KTlXO2q3aUIaOfE4fpUfa2cziohpNTB+iRcwe8ieoUlHvNumDUMH7+7jOWJpb86O1uFdrmqucSTNrnK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30f9fdf5-bf4e-48ae-bc13-08d641b51895
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;3:ULfzSv62k9wBNMoyBRg1gBhROTUq31F/38XaKawpE2gP4VAmKDzWhLWB3ENf5M4XeH792153l8QZgSryD60mYyRFLNTqQ9HqsAFWTXZRbE9vfOcerDdKO1Ws7Eh3rr28+IZuvAdnNZGo8Y0jMkNiZV7tYj2VXSA6b5vMUZ+IKg1igREolv13yac8XeWWfcs7ijpHkInpj1lSJ67/POLqpo/MuCmAXDezREx+QcxtuZhfd1LsUYiPp/JBPSmgSe3mt5n43Ke7r5pExUguNJLS9Jz0dkxtQvG7H3tqUT8VYIsvUcTBkLBXNfPS9IYivbqHHLjP3SJE0OU+MiicwoLS+ayHiWRvfvd3OJkuL5Frvvg=;25:BrO8oWfW+GzL/5Oc5/VsA+IM61vctCV1oqNC1C6W1XWqUe5Q8Eb8P8ZdqlClF4g/T23q29hC6CM8JfFDesFfDXeJCwz1v8QoTq4dXHaXP1/Nbvg6PEJe0kBrHmKVWhoLGZEd3TFwP3oFWthTs5awp4Se66EuSm+r1js410O5ziKxqHxDIntzWSscL0Th3q5WuvLNoiK6WniRc0ky2CUHbURNNYw5sJm7EjLCHExcLTqHnBMIhk/1xisKRK+va4HtNxlQriLUbBAosANMEfwXSnzg2b4JCdqVTQZFw/5z0Y5pRpMCJVHxjH/CX/1O+uhzaM8HfSxhsItpea3pKdPCCA==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1864:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;31:3uKyYy11Ht9GTCMVt6E2lmuYcddD6e24ceIfRK3uE9Ymm+Jv/Biefo9lhx6cMZB8u4nL9RsJpwHUIdR+XGYtlqH0iJpwv6iO6HNkzGMUPRb6EO/yAFrmW1noWqprY3JhRzioEWF4S9tGz5NNFjP6hxrPP5TINJeWBDq6N3xkewZLI5zVeNnXQi+ZijyOpe7Zo4pLjFUdtVDbgc4szs9YclxjBmL1NnS9rbO7tLqmWs8=;20:tyzeq4xAiUCbEXIgw3THrX1xLXg+k4dwGlkUlGTueyFeYxk4P89PmJ5s5xntw1fKxkucAm6RGScP1Ehg9+jYyXbdONVjl+nZu/q5ghOId2PQz7vCnM88BcDkHYhXukgS1Rrzb9WABNrChhkQn0OqjhTAIjjffAKkPwqUokXsHk1riDCnUKGJDJ3Qy7Etf+oFxrjLVQtMADH4IhWmACa1xmeTuZU5pEnVbq8KFNgOIwA7Cch/IT+nRG9Df1U5mmveziCCKMXzcjAoCHytStD3s7fbR+uKwi+4p8xOxWBVqg4f1T7t7XsqVa2xrz4dgbfysETMvBjSkDyCecYO3QBRjhAFM/rdCWr8D92AG/ME2zgWWI66VH5vNFJ4XdQoO+Pj3uRWtRauWX91EkVyohBcg2KXhE5ybL4eG+S6scLchYHS6XtWD4yQvmomb9yQqvbjYoX1Nj4dzQYhRam5YAr7cURT25K+TM+HmIHoG0uVu8NHyyzj4Euv7rh5dKCHsreB
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1864CC6B1A66503B668ED35FDDC80@BY1PR0701MB1864.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1864;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;4:5l3uThOV/yBK87ohZcRoGA5ETAFeM3I4yS2HiBrMk9xxRlB7BtANuje7wNTIrPuLwpvsLf3gh/YYw3cNfAoDUoQUIuU+dtebShq9SoO/yO+toxo7JBktxxH02M7kS7BU3P5S3hvO8PG+sD+nRPiLrlu8eA4lrb2Lab17UwcwRUjXH135j2pas6hwOjGOcLq7UespQst+s01FLIM2s5JmG345lzviAOmIC7RQYud2jnqg0JbOq8jYR0fgmCRy9ABojpdZUuB279oXgH2KgldVHJUmUn7NviUGe0k+xXhYf5mjzP74OLkh8F//a093ZZEdy6wCYLoPKy+cT6G84yRWaEE3q4XWrGJJvlvttpEQIEY=
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1864;23:vOvzXiDwPfCAekG3VUUxMJ/JFzDZQ03X4wBOwF5?=
 =?us-ascii?Q?o+Qtb8AmcaxQ1BVQJJuUvuOk6a97Wg4ewkSHyZeNKs+3VFRDKaiPkFK0my9t?=
 =?us-ascii?Q?sjxBapF7jITcfMIOjA7UlMKrrm/EIUHtIWLkO9EN+fHBJLmWR1X/IR3Zw4vG?=
 =?us-ascii?Q?o++UMv9n8KBui0B6lvTp7vyosn1zzzbGJmxIOvHGK+yOvALgaZRYelIWRXWj?=
 =?us-ascii?Q?GajfBYHuT+5ExlcR9OvHL2nvpy4/iTDdMsqQikeLepgnFJ/HRdvetGLIW4qf?=
 =?us-ascii?Q?8UGWC7GAKqcjD84cP61ivG5qS+TahfUFi78/mBzcEVomu2be3Sj9gy/nRY+1?=
 =?us-ascii?Q?03h1gZ42wcsBp/fREMOghtEKbW2YrJTVs8Bs4S+1D5YPnB54QADrrUqnUn8g?=
 =?us-ascii?Q?yp9DOCAY5d5rRUPZIddZkbtQXkHDzfZOTLkfiigcxMvpEOG+GLdtwTIVG+EI?=
 =?us-ascii?Q?HlLNVXnWsOTzZtdgmZuwqxVhOdJZvU+lb9DckhlmCdn/iJSYFaszoIT+a3q1?=
 =?us-ascii?Q?x9rOFYLJC7GMpIO/kAL6dMGNrbAGmPVue7baoY4iex5XP/f61NCFacF73BCG?=
 =?us-ascii?Q?f1uZwiMDjED0seWdGTkdTcn+FPgBmcoObaDCsOM9xG9Eji47ofBRWOLwPasm?=
 =?us-ascii?Q?GBYX3T5+UWEi3q2jxOs7zPrES7ALQZbBTBaFaDfKSFBe5hiKiaDjDnv6rUrS?=
 =?us-ascii?Q?tsP1AMnRxqrEPTkj6GWKTxjJwjFrH0aIdSx+I8+b0spc2ENBr61CJms/hdsC?=
 =?us-ascii?Q?5IoiQvBuitcLLWhJMbYqHR9R7dkvciWyLWjEuHQhg6mG/irOkGxrrqGEcZYO?=
 =?us-ascii?Q?b98lXv3sePw1hRQ+GioOal7HRUnvwcK8lEJ6jI8VzPo1+wgeQ8iFtxEWBC78?=
 =?us-ascii?Q?lsRT/Tkt3UPtmSEt1tiRHwlHmpHzl6J2lJ736mGTfQSVyyl4Ip/LomX5PeDH?=
 =?us-ascii?Q?ZHySjlAROtlzxW4ycphW9Vs85tL6uN8LcKoz0rUNyTEyS4NwisOoIYCOSx27?=
 =?us-ascii?Q?Y7wGf9dx43gV9wE04TNeyl+0T5N1jbG5PjkwhZUqGnUIYy37RAJaGAbB6scY?=
 =?us-ascii?Q?VqnLvx2x0WPoFrq6Ereh9z26OrdrEUQ54YwOtLG8FpdjkRGDvRpE8m+u9KG+?=
 =?us-ascii?Q?LGbT/sIcDkQpAShUz2Op9QkKzI9i0eqT2mBt6elpUHXNYRurWJ6G2jLCSzcr?=
 =?us-ascii?Q?7DG7E3r1G81lJpG5vS1CJpKqeXb8EmHJabv31?=
X-Microsoft-Antispam-Message-Info: KWgUO0cYt/IFjJfvDD04BzW/WPxur1zctVdqewqlxzH5zmUwzCEMysDE3W2vpeG23mJoH8YRNB4oYM6sAVMMuESs0ykHmzNoHVrhKFOa8CelVQuRSyyOXfgzpa5hsQ5cDa1DqX/mGPUc5e1rG01AJV5jGzMr49dRPCePEiUFZDBnio/Cjsikoz53uJ0yIMxiD4gyU6qP1XOjF/vumzou+gNZrH24u4kfyG0vMXxOpTh3DYsxB9pLa6TBqFw1IvRUYrP4FF3CvIFHLi+5c4n5amblPJc+jO/+J0XBX1rd7Ws50Cb3n1Sr+ETJcM+5VqmHMzggs8hzHEbHRgSo89oiNzGTDIhnqANF2OWkSmmFWko=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;6:lBQMdyuzOVNbuUXiE/jZCFsYrsQCd39cnQHSZWefB4gocFKRHBfAa2LS+mGDQq1sfYPsnt4SiJGwaLKbUCI6B4SzghgsdlX94i+4uH4bAJWewRnOZZQexbbQ2Sxx+n6x2KH8Tt0xTG6iLt2wbzeWfhRyJtD/N7odOjVtK7tnqaSyqchGO076RLATEj8xI4S5yQyjzsZjrgogAYXxIw061oFzE9tS1fcxvbeSI2s7QoRje60gQEJ9RxGz2Ct59sjBY+kNT4EJbIVyXz9FZpY9SU6NYfxn4neOell+TxsqSq/MHIhtQXFTiqPKnhiFND3/UzZdjAKz7upOAed62x8zBXoCyEbR+n+mBpW4Du3htqaFMiL99BAF1iQPOD5Yh26srOUZ0J/jQ2cKxES3wEuNr5rSffqCe+cTEnj0alj6nmJIQdiGJlsUQ2i1821jHgXWdeGf4fwos6Hu/g2lv1HmvQ==;5:tluBhpcvawB0HAIlFsG01i0Qb9DNkdIlrrgvGKoeA/RCMg4S06RvfoGAN26eONQjWaDcdsGAZ9F4TYFr2/QYAgrV0NNzWVFq5IfPHG/fpwhVCa4N/PFd9RvzSM0kupMX6SCUFigbwAK42rYPQbJlMrHKjYVSMoUv3Ez7fqLqVTA=;7:3WyTQcJyrBXT2nWSDBPGSMFCVEpMp5PA6xsUytB25Vl2CqRFXqvivMmk2mf02jWzLgh1N1iGjEIkZ8GFop8P/VVgQne7TMOkzeKvTls7ypAhhtY+FFANXnDf/q4e88b7hnhYo5rzgqYFNmDP5/Z+nA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;20:ixVJfa2qozufgIzN24jB15Rqgz3p/7trHQcLsASO2oFz1FlZU3wXS+4axb+C5PJlKnm+WDOTHl1OPJGgTTPKq0Md+y3JhbyuVSRr6hMXwhkYvVBTFZCVO9uAXz2bZZZdRKW3Pu3V6KASvLBCFdueaknkJajygVcblvoee+5DP23cRTD/5b4j775srEZjAHbLCREUcJwJnrZDcB/nX63yF+dV6WJMzEDMzU+eIUoGKG39Lz7Yt1eD2g5TAOw++0ac
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:17.4668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f9fdf5-bf4e-48ae-bc13-08d641b51895
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1864
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds core.c and core.h file that implements initialization
of platform driver and adds function responsible for selecting,
switching and running appropriate Device/Host mode.

Patch also adds gadget.c, host.c, gadget-export.h, host-export.h.
These files contains templates functions used during initialization.
The implementation will be added in next patches.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Kconfig         |  20 ++
 drivers/usb/cdns3/Makefile        |   4 +
 drivers/usb/cdns3/core.c          | 373 ++++++++++++++++++++++++++++++
 drivers/usb/cdns3/core.h          |  88 +++++++
 drivers/usb/cdns3/gadget-export.h |  27 +++
 drivers/usb/cdns3/gadget.c        |  36 +++
 drivers/usb/cdns3/host-export.h   |  30 +++
 drivers/usb/cdns3/host.c          |  28 +++
 8 files changed, 606 insertions(+)
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 888458372adb..5f88a4932e58 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -10,6 +10,26 @@ config USB_CDNS3
 
 if USB_CDNS3
 
+config USB_CDNS3_GADGET
+	bool "Cadence USB3 device controller"
+	depends on USB_GADGET
+	help
+	  Say Y here to enable device controller functionality of the
+	  cadence USBSS-DEV driver.
+
+	  This controller support FF, HS and SS mode. It doeasn't support
+	  LS and SSP mode
+
+config USB_CDNS3_HOST
+	bool "Cadence USB3 host controller"
+	depends on USB_XHCI_HCD
+	help
+	  Say Y here to enable host controller functionality of the
+	  cadence driver.
+
+	  Host controller is compliance with XHCI so it will use
+	  standard XHCI driver.
+
 config USB_CDNS3_PCI_WRAP
 	tristate "PCIe-based Platforms"
 	depends on USB_PCI && ACPI
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index dcdd62003c6a..083676c7748f 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -1,3 +1,7 @@
+obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
 
+cdns3-y					:= core.o
+cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o
+cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
 cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
new file mode 100644
index 000000000000..727136235957
--- /dev/null
+++ b/drivers/usb/cdns3/core.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Peter Chen <peter.chen@nxp.com>
+ *         Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include "gadget.h"
+#include "core.h"
+#include "host-export.h"
+#include "gadget-export.h"
+
+static inline struct cdns3_role_driver *cdns3_role(struct cdns3 *cdns)
+{
+	WARN_ON(cdns->role >= CDNS3_ROLE_END || !cdns->roles[cdns->role]);
+	return cdns->roles[cdns->role];
+}
+
+static inline int cdns3_role_start(struct cdns3 *cdns, enum cdns3_roles role)
+{
+	int ret;
+
+	if (role >= CDNS3_ROLE_END)
+		return 0;
+
+	if (!cdns->roles[role])
+		return -ENXIO;
+
+	mutex_lock(&cdns->mutex);
+	cdns->role = role;
+	ret = cdns->roles[role]->start(cdns);
+	mutex_unlock(&cdns->mutex);
+	return ret;
+}
+
+static inline void cdns3_role_stop(struct cdns3 *cdns)
+{
+	enum cdns3_roles role = cdns->role;
+
+	if (role == CDNS3_ROLE_END)
+		return;
+
+	mutex_lock(&cdns->mutex);
+	cdns->roles[role]->stop(cdns);
+	cdns->role = CDNS3_ROLE_END;
+	mutex_unlock(&cdns->mutex);
+}
+
+static void cdns3_set_role(struct cdns3 *cdns, enum cdns3_roles role)
+{
+	if (role == CDNS3_ROLE_END)
+		return;
+
+	if (role == CDNS3_ROLE_HOST) {
+		//TODO: set host role
+	} else { /* gadget mode */
+		//TODO: set device role
+	}
+}
+
+static enum cdns3_roles cdns3_get_role(struct cdns3 *cdns)
+{
+	if (cdns->roles[CDNS3_ROLE_HOST] && cdns->roles[CDNS3_ROLE_GADGET]) {
+		//TODO: implements selecting device/host mode
+		return CDNS3_ROLE_HOST;
+	}
+	return cdns->roles[CDNS3_ROLE_HOST]
+		? CDNS3_ROLE_HOST
+		: CDNS3_ROLE_GADGET;
+}
+
+/**
+ * cdns3_core_init_role - initialize role of operation
+ * @cdns: Pointer to cdns3 structure
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_core_init_role(struct cdns3 *cdns)
+{
+	struct device *dev = cdns->dev;
+	enum usb_dr_mode dr_mode;
+
+	dr_mode = usb_get_dr_mode(dev);
+	cdns->role = CDNS3_ROLE_END;
+
+	if (dr_mode == USB_DR_MODE_UNKNOWN) {
+		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
+		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
+			dr_mode = USB_DR_MODE_OTG;
+		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
+			dr_mode = USB_DR_MODE_HOST;
+		else if (IS_ENABLED(CONFIG_USB_CDNS3_DEVICE))
+			dr_mode = USB_DR_MODE_PERIPHERAL;
+	}
+
+	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
+		if (cdns3_host_init(cdns))
+			dev_info(dev, "doesn't support host\n");
+	}
+
+	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
+		if (cdns3_gadget_init(cdns))
+			dev_info(dev, "doesn't support gadget\n");
+	}
+
+	if (!cdns->roles[CDNS3_ROLE_HOST] && !cdns->roles[CDNS3_ROLE_GADGET]) {
+		dev_err(dev, "no supported roles\n");
+		return -ENODEV;
+	}
+
+	cdns->dr_mode = dr_mode;
+	return 0;
+}
+
+/**
+ * cdns3_irq - interrupt handler for cdns3 core device
+ *
+ * @irq: irq number for cdns3 core device
+ * @data: structure of cdns3
+ *
+ * Returns IRQ_HANDLED or IRQ_NONE
+ */
+static irqreturn_t cdns3_irq(int irq, void *data)
+{
+	struct cdns3 *cdns = data;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (cdns->in_lpm) {
+		disable_irq_nosync(cdns->irq);
+		cdns->wakeup_int = true;
+		pm_runtime_get(cdns->dev);
+		return IRQ_HANDLED;
+	}
+
+	/* Handle device/host interrupt */
+	if (cdns->role != CDNS3_ROLE_END)
+		ret = cdns3_role(cdns)->irq(cdns);
+
+	return ret;
+}
+
+static void cdns3_remove_roles(struct cdns3 *cdns)
+{
+	cdns3_gadget_remove(cdns);
+	cdns3_host_remove(cdns);
+}
+
+static int cdns3_do_role_switch(struct cdns3 *cdns, enum cdns3_roles role)
+{
+	enum cdns3_roles current_role;
+	int ret = 0;
+
+	if (cdns->role == role)
+		return 0;
+
+	pm_runtime_get_sync(cdns->dev);
+	current_role = cdns->role;
+	cdns3_role_stop(cdns);
+
+	if (role == CDNS3_ROLE_END) {
+		pm_runtime_put_sync(cdns->dev);
+		return 0;
+	}
+
+	dev_dbg(cdns->dev, "Switching role");
+
+	cdns3_set_role(cdns, role);
+	ret = cdns3_role_start(cdns, role);
+	if (ret) {
+		/* Back to current role */
+		dev_err(cdns->dev, "set %d has failed, back to %d\n",
+			role, current_role);
+		cdns3_set_role(cdns, current_role);
+		ret = cdns3_role_start(cdns, current_role);
+	}
+
+	pm_runtime_put_sync(cdns->dev);
+	return ret;
+}
+
+/**
+ * cdns3_role_switch - work queue handler for role switch
+ *
+ * @work: work queue item structure
+ *
+ * Handles below events:
+ * - Role switch for dual-role devices
+ * - CDNS3_ROLE_GADGET <--> CDNS3_ROLE_END for peripheral-only devices
+ */
+static void cdns3_role_switch(struct work_struct *work)
+{
+	struct cdns3 *cdns;
+	bool device, host;
+
+	cdns = container_of(work, struct cdns3, role_switch_wq);
+
+	//TODO: implements this functions.
+	//host = cdns3_is_host(cdns);
+	//device = cdns3_is_device(cdns);
+	host = 1;
+	device = 0;
+
+	if (host) {
+		if (cdns->roles[CDNS3_ROLE_HOST])
+			cdns3_do_role_switch(cdns, CDNS3_ROLE_HOST);
+		return;
+	}
+
+	if (device)
+		cdns3_do_role_switch(cdns, CDNS3_ROLE_GADGET);
+	else
+		cdns3_do_role_switch(cdns, CDNS3_ROLE_END);
+}
+
+/**
+ * cdns3_probe - probe for cdns3 core device
+ * @pdev: Pointer to cdns3 core platform device
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource	*res;
+	struct cdns3 *cdns;
+	void __iomem *regs;
+	int ret;
+
+	cdns = devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
+	if (!cdns)
+		return -ENOMEM;
+
+	cdns->dev = dev;
+
+	platform_set_drvdata(pdev, cdns);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "missing IRQ\n");
+		return -ENODEV;
+	}
+	cdns->irq = res->start;
+
+	/*
+	 * Request memory region
+	 * region-0: xHCI
+	 * region-1: Peripheral
+	 * region-2: OTG registers
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+	cdns->xhci_regs = regs;
+	cdns->xhci_res = res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+	cdns->dev_regs	= regs;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+	cdns->otg_regs = regs;
+
+	mutex_init(&cdns->mutex);
+
+	ret = cdns3_core_init_role(cdns);
+	if (ret)
+		goto err2;
+
+	INIT_WORK(&cdns->role_switch_wq, cdns3_role_switch);
+	if (ret)
+		goto err3;
+
+	if (ret)
+		goto err3;
+
+	cdns->role = cdns3_get_role(cdns);
+	cdns3_set_role(cdns, cdns->role);
+	ret = cdns3_role_start(cdns, cdns->role);
+	if (ret) {
+		dev_err(dev, "can't start %s role\n", cdns3_role(cdns)->name);
+		goto err3;
+	}
+
+	ret = devm_request_irq(dev, cdns->irq, cdns3_irq, IRQF_SHARED,
+			       dev_name(dev), cdns);
+
+	if (ret)
+		goto err4;
+
+	device_set_wakeup_capable(dev, true);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/*
+	 * The controller needs less time between bus and controller suspend,
+	 * and we also needs a small delay to avoid frequently entering low
+	 * power mode.
+	 */
+	pm_runtime_set_autosuspend_delay(dev, 20);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_use_autosuspend(dev);
+	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
+
+	return 0;
+
+err4:
+	cdns3_role_stop(cdns);
+err3:
+	cdns3_remove_roles(cdns);
+err2:
+	return ret;
+}
+
+/**
+ * cdns3_remove - unbind drd driver and clean up
+ * @pdev: Pointer to Linux platform device
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_remove(struct platform_device *pdev)
+{
+	struct cdns3 *cdns = platform_get_drvdata(pdev);
+
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	cdns3_remove_roles(cdns);
+	usb_phy_shutdown(cdns->usbphy);
+
+	return 0;
+}
+
+static struct platform_driver cdns3_driver = {
+	.probe		= cdns3_probe,
+	.remove		= cdns3_remove,
+	.driver		= {
+		.name	= "cdns-usb3",
+	},
+};
+
+static int __init cdns3_driver_platform_register(void)
+{
+	cdns3_host_driver_init();
+	return platform_driver_register(&cdns3_driver);
+}
+module_init(cdns3_driver_platform_register);
+
+static void __exit cdns3_driver_platform_unregister(void)
+{
+	platform_driver_unregister(&cdns3_driver);
+}
+module_exit(cdns3_driver_platform_unregister);
+
+MODULE_ALIAS("platform:cdns3");
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
new file mode 100644
index 000000000000..e7159c474308
--- /dev/null
+++ b/drivers/usb/cdns3/core.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence USBSS DRD Driver.
+ *
+ * Copyright (C) 2017 NXP
+ * Copyright (C) 2018 Cadence.
+ *
+ * Authors: Peter Chen <peter.chen@nxp.com>
+ *          Pawel Laszczak <pawell@cadence.com>
+ */
+#include <linux/usb/otg.h>
+
+#ifndef __LINUX_CDNS3_CORE_H
+#define __LINUX_CDNS3_CORE_H
+
+struct cdns3;
+enum cdns3_roles {
+	CDNS3_ROLE_HOST = 0,
+	CDNS3_ROLE_GADGET,
+	CDNS3_ROLE_END,
+	CDNS3_ROLE_OTG,
+};
+
+/**
+ * struct cdns3_role_driver - host/gadget role driver
+ * @start: start this role
+ * @stop: stop this role
+ * @suspend: suspend callback for this role
+ * @resume: resume callback for this role
+ * @irq: irq handler for this role
+ * @name: role name string (host/gadget)
+ */
+struct cdns3_role_driver {
+	int (*start)(struct cdns3 *cdns);
+	void (*stop)(struct cdns3 *cdns);
+	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
+	int (*resume)(struct cdns3 *cdns, bool hibernated);
+	irqreturn_t (*irq)(struct cdns3 *cdns);
+	const char *name;
+};
+
+#define CDNS3_NUM_OF_CLKS	5
+/**
+ * struct cdns3 - Representation of Cadence USB3 DRD controller.
+ * @dev: pointer to Cadence device struct
+ * @xhci_regs: pointer to base of xhci registers
+ * @xhci_res: the resource for xhci
+ * @dev_regs: pointer to base of dev registers
+ * @otg_regs: pointer to base of otg registers
+ * @irq: irq number for controller
+ * @roles: array of supported roles for this controller
+ * @role: current role
+ * @host_dev: the child host device pointer for cdns3 core
+ * @gadget_dev: the child gadget device pointer for cdns3 core
+ * @usbphy: usbphy for this controller
+ * @role_switch_wq: work queue item for role switch
+ * @in_lpm: the controller in low power mode
+ * @wakeup_int: the wakeup interrupt
+ * @mutex: the mutex for concurrent code at driver
+ * @dr_mode: requested mode of operation
+ * @current_dr_role: current role of operation when in dual-role mode
+ * @desired_dr_role: desired role of operation when in dual-role mode
+ * @root: debugfs root folder pointer
+ */
+struct cdns3 {
+	struct device			*dev;
+	void __iomem			*xhci_regs;
+	struct resource			*xhci_res;
+	struct cdns3_usb_regs __iomem	*dev_regs;
+	struct cdns3_otg_regs		*otg_regs;
+	int irq;
+	struct cdns3_role_driver	*roles[CDNS3_ROLE_END];
+	enum cdns3_roles		role;
+	struct device			*host_dev;
+	struct device			*gadget_dev;
+	struct usb_phy			*usbphy;
+	struct work_struct		role_switch_wq;
+	int				in_lpm:1;
+	int				wakeup_int:1;
+	/* mutext used in workqueue*/
+	struct mutex			mutex;
+	enum usb_dr_mode		dr_mode;
+	enum usb_dr_mode		current_dr_mode;
+	enum usb_dr_mode		desired_role;
+	struct dentry			*root;
+};
+
+#endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
new file mode 100644
index 000000000000..257e5e0eef31
--- /dev/null
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence USBSS DRD Driver -Gadget Export APIs
+ *
+ * Copyright (C) 2017 NXP
+ *
+ * Authors: Peter Chen <peter.chen@nxp.com>
+ */
+#ifndef __LINUX_CDNS3_GADGET_EXPORT
+#define __LINUX_CDNS3_GADGET_EXPORT
+
+#ifdef CONFIG_USB_CDNS3_GADGET
+
+int cdns3_gadget_init(struct cdns3 *cdns);
+void cdns3_gadget_remove(struct cdns3 *cdns);
+#else
+
+static inline int cdns3_gadget_init(struct cdns3 *cdns)
+{
+	return -ENXIO;
+}
+
+static inline void cdns3_gadget_remove(struct cdns3 *cdns) { }
+
+#endif
+
+#endif /* __LINUX_CDNS3_GADGET_EXPORT */
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
new file mode 100644
index 000000000000..41ce696719d7
--- /dev/null
+++ b/drivers/usb/cdns3/gadget.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver - gadget side.
+ *
+ * Copyright (C) 2018 Cadence Design Systems.
+ * Copyright (C) 2017 NXP
+ *
+ * Authors: Pawel Jez <pjez@cadence.com>,
+ *          Pawel Laszczak <pawell@cadence.com>
+ *	    Peter Chen <peter.chen@nxp.com>
+ */
+
+#include "core.h"
+
+/**
+ * cdns3_gadget_remove: parent must call this to remove UDC
+ *
+ * cdns: cdns3 instance
+ */
+void cdns3_gadget_remove(struct cdns3 *cdns)
+{
+	//TODO: implements this function
+}
+
+/**
+ * cdns3_gadget_init - initialize device structure
+ *
+ * cdns: cdns3 instance
+ *
+ * This function initializes the gadget.
+ */
+int cdns3_gadget_init(struct cdns3 *cdns)
+{
+	//TODO: implements this function
+	return 0;
+}
diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
new file mode 100644
index 000000000000..f8f3b230b472
--- /dev/null
+++ b/drivers/usb/cdns3/host-export.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence USBSS DRD Driver -Host Export APIs
+ *
+ * Copyright (C) 2017 NXP
+ *
+ * Authors: Peter Chen <peter.chen@nxp.com>
+ */
+#ifndef __LINUX_CDNS3_HOST_EXPORT
+#define __LINUX_CDNS3_HOST_EXPORT
+
+#ifdef CONFIG_USB_CDNS3_HOST
+
+int cdns3_host_init(struct cdns3 *cdns);
+void cdns3_host_remove(struct cdns3 *cdns);
+void cdns3_host_driver_init(void);
+
+#else
+
+static inline int cdns3_host_init(struct cdns3 *cdns)
+{
+	return -ENXIO;
+}
+
+static inline void cdns3_host_remove(struct cdns3 *cdns) { }
+static inline void cdns3_host_driver_init(void) {}
+
+#endif /* CONFIG_USB_CDNS3_HOST */
+
+#endif /* __LINUX_CDNS3_HOST_EXPORT */
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
new file mode 100644
index 000000000000..37300985e2d6
--- /dev/null
+++ b/drivers/usb/cdns3/host.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS DRD Driver - host side
+ *
+ * Copyright (C) 2018 Cadence Design Systems.
+ * Copyright (C) 2018 NXP
+ *
+ * Authors: Peter Chen <peter.chen@nxp.com>
+ *	    Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include "core.h"
+
+int cdns3_host_init(struct cdns3 *cdns)
+{
+	//TODO: implements this function
+	return 0;
+}
+
+void cdns3_host_remove(struct cdns3 *cdns)
+{
+  //TODO: implements this function
+}
+
+void __init cdns3_host_driver_init(void)
+{
+	//TODO: implements this function
+}
-- 
2.17.1

