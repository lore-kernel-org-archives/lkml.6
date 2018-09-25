Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BBAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A903620877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TqXF9Vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A903620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeIYPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:22:53 -0400
Received: from mail-co1nam03on0077.outbound.protection.outlook.com ([104.47.40.77]:48813
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727606AbeIYPWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTmsPJ0g3bhxF0DuVhAFCvaiTsxFQXOSwUvsZbAtsmA=;
 b=0TqXF9Vs2IahOPzKTVzSkFQ7EZxYnbam1SePV0S372+XwPKvw2Z81EmZC/RYaoHtidAmzMkXcox3URteQMxDchzJrsskfdEfaAPjROS7pNcC3+uGKMG+XP465hgGnBfdTZtZCbg6NETOsaF2efG/A8i/3Gw+xDoK45iv+pRBhKU=
Received: from [10.136.128.44] (202.56.249.162) by
 DM5PR12MB1659.namprd12.prod.outlook.com (2603:10b6:4:11::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 09:16:10 +0000
Subject: Re: [PATCH] xhci: Add check for invalid byte size error when UAS
 devices are connected.
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com
References: <1537536150-11721-1-git-send-email-Sandeep.Singh@amd.com>
 <58201720-ee34-a866-b177-084b9f36c40c@linux.intel.com>
Cc:     Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
From:   Sandeep Singh <ssingh1@amd.com>
Message-ID: <4ccf6cbc-cdf6-c6f0-486d-b971837d1c8a@amd.com>
Date:   Tue, 25 Sep 2018 14:44:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <58201720-ee34-a866-b177-084b9f36c40c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::26) To DM5PR12MB1659.namprd12.prod.outlook.com
 (2603:10b6:4:11::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72832d3c-1fdd-4ec1-cddc-08d622c78a01
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1659;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1659;3:i8i3mCr6Y4kHc0W5Zjy8Pd1YjwVayRWOW9sBebHBMXFhUZih5QXHcsAY1rA1Kd0pe4ZuSosXcXWUBpg9JHdE676ifBVDI4bEVrqiJxk2QXwzJvon3mwucVJhby0p4YxP9nnr0pjbV2aa0lO1tDkAEiVbQ7l8Z1xd9sTt3nSUZ1Wtr3uIzQ1ahUD1KoohchV4AilQ17Tz23SsNvnUvS+rFYcarYzpQ2/i8+yBYJQof7s+l/kWTPDVU2tkYjxIfICT;25:SYW4fWVafnGhWDGsPun179VLYDWeonfOOuyCed50MHPUit7qRUZASl1B4nP/2aJaLrb4NHVICHWXt1whtuZRmzb7U3c0bmYVCtQSGy9FOLBBEcj0OYBOGlkNiAQLgcIski6y9+Ac+trEQcWpimONoPU09oYomCYwJYCKPJrtn9JlqXe6gDgrY2srq3xu87OhN/aMY6/4eBeiMrqfM0ArOUSt1dWSwG0rbTUjp6Er2mXcKlQAoyRcyN9KOYMlbLYdHgrND/p19KSrmHQv2n/JOkXb6GQ64jYhM9i7CHLrcCnO/5WNiRV+h06uMjEZmXyzvFWX6sMTTkY9cm7wdPCcsQ==;31:WNqCODAFQObjQSl5wuv9r/BTJDV22CZyJAjnYPTpNZuGl8CjeC6xCxmDG1kbGnhr8AWapo23QCGra+DmasSl43OnoKANyc7aQu0dp00Z8bnOAqGqqMEjud/3fNlvAnlo6VgLSgk5MTyoEKnEci01K1FDHE7vebtGbqK9ZDUJRQGOWP75jQhjGF559gDDf44aJSud/kwpyReCJtWMropDA0N6ReOjiGqgBDODDolDMUM=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1659;20:cOEvs3V2i0htMvm+aCLbaZ/wXC+7RjvHOugoMVD7vhATLn7Eja2WCdIytCPc7oZZ5K5T6aV3UTPRGn7+FVS2d5Fjyg6t7xFGh8RLf2yL4lTDHbVVXczoWUbq6gv01gIyktb1ZyP9DLQt6oOy6/7TZbRZiTCZTJkiNttQRGKiG0YsA4uT2sOoG90aTRbvEf3lyjuIbyB+NQrP7vRe+HPejfjByaQiAW5pA4BMT6Ocqi1X70Pp55bhlxP40DJF2MBoeFDrD5qkkcs1I+XzTiMxy8dyU5aSml6knp3Pt6v/XzbfNF4URCAeKCggSHMK6DASZi6wQO0Ds/3zxF+k7Yj3G4ffUettkL/lTC8OFZric+rXcsMmwM/mBPWNEAFduD2FIUXGlEb9+GQB86uqBrIPlpPVSiSwZ/m/dBOqtB+LOS9UYENCm+iAEZSyV9XiSiycK701mWGNc62Nat272NHoOrYCNailHaD8m1zIC+dbN03Td6XLccfVZumZyB2K+mBF;4:T3HiVihpHMUSD7gE+2lQj8UrPZDC/auFR31KdT0fWzVdeBe7yxkLlYLyYvKP3BCalMvCuarSj8Gzuw22W0YPxYSGVTmhIKp8thd4gQz9crkG4wGJHONWL+v1KdnjgdpuHiPs8RTEAZTEAne0e3091L9EUrHyr5CmIXyOn5TzUHUk1Szkw/EPNlWp2LDAtySsUMxLh999lnYUOQkCxbW0/n2KHt7N7dITV7BRsGjCbRYB8onW8HZ5SgGa9OjOnGtGbYASBlmcw0Q5g4gGspMbRsV2eniC0L5phMAWY2spc5SHmkfI4CNTZc9zunIXasKo
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659E0D4BA5DF37D633FE72CE0160@DM5PR12MB1659.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:DM5PR12MB1659;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1659;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(105586002)(6346003)(77096007)(5660300001)(16526019)(16576012)(26005)(316002)(31686004)(65826007)(68736007)(81166006)(64126003)(81156014)(8676002)(230700001)(6666003)(6116002)(386003)(53546011)(106356001)(3846002)(8936002)(97736004)(50466002)(6246003)(6486002)(76176011)(31696002)(486006)(3260700006)(229853002)(11346002)(53936002)(52116002)(476003)(36756003)(2616005)(52146003)(478600001)(2486003)(23676004)(66066001)(446003)(65956001)(956004)(25786009)(47776003)(4326008)(65806001)(72206003)(110136005)(54906003)(305945005)(2906002)(7736002)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1659;H:[10.136.128.44];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNjU5OzIzOnp0b0U0NVRONmp1cEpmZ3NoOTRIcUJ5amFy?=
 =?utf-8?B?NENYOGJFNC9Cc0xwa0VmZ3pCTitQajE1czlYVnBsRmNsYjY5d0lGc2JtaFdV?=
 =?utf-8?B?M0lKdXd1ZFE4UHdxR28rcTRRRXUvVFZXcTFtQ2N3R0NnaDJXYzJka2o3NytP?=
 =?utf-8?B?c1cxT3kxcFpBOU4zWFVZa2VlUnhVUkFVa0lMQ3BFKzhHM1JwZDBhSGFhSkJZ?=
 =?utf-8?B?bmRieGZGTGE4Nm9XQklZV29xdktsRGNxamJvWGpEdkpQWU9PSnB0TlFYOC9m?=
 =?utf-8?B?YUtlbHZyM0JBcHg5NlBIdGorZDAyYjFjVlJ0VEtPMG4zajV5bktRWkhVdEw1?=
 =?utf-8?B?cnBXNEJWTHRkcncrMHBERSs4ZjVrV1E0U3JPVnBVTzVSVVQ5R2dLV0tBUHVZ?=
 =?utf-8?B?ZmxmdHU2bkJvRWxFRllWNlVFSng1TFpNU2w2TmZXRjFWZGJscFA1RytJZk4z?=
 =?utf-8?B?Qk9MVDRkWVNwMG84aXlVNzZ6TXlHcXY5NHlPZm9rSkN6TUhvU2FkMTVCdHB2?=
 =?utf-8?B?VStpUTd3UlYxdisycXdsNWs4ZUs3TEQwZXJmcG5UZ3lCdWtZM0VPSmJCdmlV?=
 =?utf-8?B?ZzVpRGlsVDhEYy9nR3lDUVJrV2dVbWRONGpSWDlBSUpJakhRaVVRaHNWam9D?=
 =?utf-8?B?TVNZV3pJa1h2ckc5Vi8wNzJ0ZWI4em1tWm8xQ3VnYjVyQ3dyVlh4ZFp1Rlo0?=
 =?utf-8?B?YXJwL3R0RmlJRFEvbXdpU3NBWm5Yb2p1WUQrVkZzRWFlT0NwanF3MDFEZnJJ?=
 =?utf-8?B?bHFES3JVS0xURVNJM1ljNHdsZmpyUFV6dkQ2d2FZZFhVMVU1RTZ2WkRJSU01?=
 =?utf-8?B?VDRtZ0tqdlRWM1BLT3hXTmp3UUl5dDkvUU5LYUp3MXB4dy93NDFwK1N5andw?=
 =?utf-8?B?aVc5bGdEejVTT1J5TnRrajBtdWQvV1l6UWo1QzRPdk1oc1lOZUdGOEZtWkl5?=
 =?utf-8?B?YzlLVHF2THMxQ0lQZW1SUXdWN3p1S0Jxc2hlWCtPOVVuWHIzeU8zTmJkajBI?=
 =?utf-8?B?UEpXdUZGalM2cEx4aFdKdU01b0gyWU8wbk5tN3F3Ti96M1BIR1JRdzRjQ0li?=
 =?utf-8?B?S0dadTFSekhEN1g5K3JQOUdHd2FCYmV6UjE2akljRUhVYlgvR1dUdHk3NUFw?=
 =?utf-8?B?YXdJM0sxU3RNWFloVEdjZTRhUkgraFB1TGovdW5zelR0Z01PR3V4bWR5Uk13?=
 =?utf-8?B?cUtWOFNaUU4xcVNQSHE4RDJkUU05cnJjOXYvbmhFanFpR1NwOXB0bjRJaVJn?=
 =?utf-8?B?VGV1Y3dITnpQQ0ZXeTJRUDR0WGhCOTJVdnRxTEhDK3VTUFpnNDJjVXE1eEVB?=
 =?utf-8?B?WXdlTUYzY2NJRzJYUVRrRVBVVU9GazVScG9GSGpkTkM1VVUwdHN6Wko5RGYy?=
 =?utf-8?B?VmhMQWZHeWhFSVRhYXNuTVo5R2s4MlE1c3JZT1RHUkI4ZStvZ3ZOZVhycFlS?=
 =?utf-8?B?OEZFMlJNN0luLzR5Y3JvTndEMWh5QTBZV2J6ZW53ZkNURzFMZ3pwb081MlpT?=
 =?utf-8?B?ZXc5Wld2TTVUYURRSzYrLy9iNVVZNnEyWlRmMnFPajI3ajFRWktSb0pHRUNY?=
 =?utf-8?B?cjV0OHdweHVZQWZxeE9kSVppbTAyMEVsWVg3WFpoSHlTU1NwT3Y4cFN5K1BG?=
 =?utf-8?B?VStBazhYSUNZUFNPR2xiODQvTVZ6MmswbVZCb1QzNTh3MWIyQ2gvdW83ay84?=
 =?utf-8?B?Q2Q4S1UyVEpaczBETHI5K0ZUUmlwYXVYTnBTVitTWG1nUUlQbHMzZjdGTlpq?=
 =?utf-8?B?ZmpWWXVldnk0QXJTK1pLalBtK3lLWVNxSjVDL1lQMUZ3NzBEUDd4V0VuQUxE?=
 =?utf-8?B?ZkJ0VlJubkhra3hSQ1pqUkJUL1RtS0NoMWZZNURoaVZTT1VUYTYzaStCSTdi?=
 =?utf-8?B?c3I4eVlaSTdJOWo4dndBZ09jRFF5ZFc5V05keFpQTnF2WlZ3ajVJTU14WExt?=
 =?utf-8?Q?cNa3LDvPUwf1XUMpyNrcT6ybGZIBrc=3D?=
X-Microsoft-Antispam-Message-Info: 7MMCxtCCrrvTPC3Ciphp0Pf/MKq7aXK8vV7ZVO1ixbOIY6+jPsKVkxOvWrWFRsbwBYJlcYbpN7CVvsj/xZ/wbqJjWLpCF60ItrvXtLYpQ7wwQsKurTPiTpt08bGOQXeLSktZD/nzMJI8OPyiBqCve8w5Xaq5CPP1ldLlvd26gK2MuOpC54mOX6zFxDWtVnoSCM9d8lLhmXdQ2pB5KPI2RZy1utbniDwn+XLiCFqrJBCtRr7LMR4+WxdwUKms1pOYIwLuFVS8/PCh9NUd57LcDCIU7pEARzVyLVrHQEue/rxRvzbkcsHYZQydZ1X6t5QahmKZYTSLxTW8K/hKFCA3zs2emgjbNHNopMCmFmTddWo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1659;6:8obIlv0b0atz1NxtJqOlmraP6mNyGGMHqMStTKgJSgmy7JNiwR+BzsTA5ptZJYrlh6BkYWqL8fYgYg5A2QnjNJU1o9WQBf08YzMMUUAccBkkM3pUN7LXYMyMKiTtQ/pJE70YojdG10Lu6O1Da8MaieKy83IKYK8CT61IKekBwT3WI4I05ruKyFnx2t/tOakDd0vlkmAMT0lSNgfr48QHkgBeCJeNr/TnAWCx7W+WtFNdrIT7L6YpIHdEBc0F5pB1WzHai53dxJxOoYar0UjW3OZS5EnJCAmmBw27fr+PUCgP4TEOwkGyfdLbwA8WGLDe0VtCkC8Qims9kxDNobZ4UjV3+OtUYy0l2Bz3/LopvvCzaUwrXhE6K3h0zYvE/xMgRGSkRfPlW9uzmakavc05EDHprawSMo5c+yZ4zM3jUxhYS2Pwg4Z3ELHlJ/aEvjrQsq/M07G9a2s5xbnj2sNpYQ==;5:QS1x8N3xn3Ql683uAb2wDo5xnwpHclp08lvkIPPTVmxjt6AfE0zDOnQwahINArbYEKpRT1WJeQCw6ThmrqhLC7k5FM3504QFdytmU/h3UR4AOEZ/Vtqoxg0mSVFN5SJEcfzT+iJQAsl7h/xtDcnAmn6z8UNg0mhQ1B8gDBe3lwQ=;7:cNWkdetm9dWTgK2CBLlnW0CaV7obcRPK1YRFrLc3QUPK9viQyFAdy8Q3ZWbmHOMrrG3ARfUKLmjxR4BPi81N6ZoQW5N+ynNQsvunXDAPAQBw8CpDb87ZxEJAhqeDT4Ar5EnXBh7yt0Ya4ieEYd9BQ2skpbSU3Qd0wZRMiAM+obVFSLym7+FyM/k+gVi1KNpnsBgqkxp4xly6sLXvBPhz7SMY4li6aGB+U2hFSQgkIaVch6n+B7mfHZnoqxW11tsZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1659;20:7tr3ROWln4TdJ/Lhlrba13MyrcZP7rK44mOI1L/e826l4gUUG9zRhcqBpB6GNx9NlE425hbb3ITYQgtIsKApBFrc7e5IW09oIBuDtn7H1hAw2f4tWKcnx5eLcZwp5eVl8MBBCqqJ97gHCLJ8cE+JrrFSS9T5nne7CClXGT/AVBhYiwRpr8tJ5TkS4UayLGsUZUeYcWIaIvqIqXB+0JkhXOCyzw45Sn0B0hJ7lHETP/QF3hrIEGfeWNpKOB08T6p8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:16:10.1531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72832d3c-1fdd-4ec1-cddc-08d622c78a01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2018 6:39 PM, Mathias Nyman wrote:
> On 21.09.2018 16:22, Sandeep Singh wrote:
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> Observed "TRB completion code (27)" error which corresponds to Stopped -
>> Length Invalid error(xhci spec section 4.17.4) while connecting USB to
>> SATA bridge.
>>
>> Looks like this case was not considered when the following patch[1] was
>> committed. Hence adding this new check which can prevent
>> the invalid byte size error.
>>
>> [1] ade2e3a xhci: handle transfer events without TRB pointer
>>
> 
> Thanks, adding to queue.
> 
> Just out of curiosity, was the TRB pointer bits all zeroes
> in this  Stopped -Length invalid transfer event TRB?
>
Yes, TRB pointer bits all zeroes

> -Mathias
> 
Thanks
Sandeep
