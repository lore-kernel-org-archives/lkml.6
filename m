Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C37C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65997208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oMNX+jWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65997208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeGaIZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:25:29 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com ([104.47.42.79]:52191
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbeGaIZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7EuIa0QWvfq5m1Q9KzT/O0B32tqsH26YmVqevv7ZH0=;
 b=oMNX+jWl/xHWhK/ERnIVt3EJlLP3fLDK+jc40uFVsfbCXOggrI3noOwFHm/tzyzTCVDpNt1ewrVEs4f/Ewqf9/w34o3qBmxqztW6+CLS9a2XatO+lawfRdUBsqYhIQYrpquqLA7Rz0A3l9tw4cU35uc1SY2jy08aI6absjEiLUA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 06:46:19 +0000
Subject: Re: [PATCH] drm/amdgpu/pm: Fix potential Spectre v1
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180723163232.GA17358@embeddedor.com>
 <CADnq5_Ons4y+sweZGg4LgJpfn8wzgg8xdpytLt-78PVqqg-LpA@mail.gmail.com>
 <50f9f4f3-76e1-401a-bd84-6ae746fe4647@daenzer.net>
 <CADnq5_MKR=qYCX-m4wKA47F0EejNcUmS7jsnY9=1nyKKEQhqJQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <658cd654-be3e-659a-20a7-f33034c231ce@amd.com>
Date:   Tue, 31 Jul 2018 08:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADnq5_MKR=qYCX-m4wKA47F0EejNcUmS7jsnY9=1nyKKEQhqJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6P193CA0016.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::26)
 To BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e90662a5-72d1-46c4-7179-08d5f6b154f1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:AIva6w1KzYcU8g6px/SCZ/aUNw0V5c8WTXaMET3/vQYgALwBVRlILcQlrhykawL97IRwF/83lrlLTgfQ1ZhaltCLK4VBMRzkm21M8SYIg//0MjAT9LMqriT+Hdrx7Dx6gGPAxvn4T/IgqJYIIXYkcokDKtkECpV6jGkAi0siIjm5W7ovrogExbeIvmd0NMq0mjTZu2apwJvykx/h7sqytdCEC9GZm4iJh4IX/ZP6R17k6dXbH3fpv5uCyEIrs2RG;25:tAqfoOpeVdRQVU/PlO9SQQ9XMvGRZukeH6cdWpCL/yReJIccduA07quhOit5p3yzfgXZ1nGXsrj0He1zJfzKG9ovuCzoROJmPPW8Jv7kPvLqcWRGrPC2Nv1C1CCJqvT6OqbJ6swyNGFbZBVOk7SWTWJ0+dU45azqtSya2B81YgiaVN5/N280YNUS4VJaKVDyJChkeoI4rQCPd7zx9Z4/bsNQbk4zJgP46Ms7kNuGooEGTCdk78m0rKIxBCVitFrWHRxSc/IZtA70PeDjkWQkFojSj5T5mCa2+rR3KK68odpS7lH9X6ZKEX3rLZOdS9R1JYSUX85ERvLg5C9RJ4NvOw==;31:HZI6sEPT9AqAxIBRku816ujiNVErp95w3GOBMns0T8vy6BuO6exoTN5BYDYqYSjhnEb5F9mdeUCRMrjlpCCjFqHN+IAihKk7P22JQQqr7p1+zkeMSPk2yTfskSkOCVaxakRKlcgncI0aLZiJoYvOAzYsMXHcirK2A/J8g0TNm5HKxEYm0jIgAcT64SMhrCAE0CzikjBw7BVC6JKSa4rJtFDQ//Dk2wAhgbAo0v4mAa8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:f+kSbGC8E9EuvPfOd7r+QYzh2y5E9NLeKQ3HkaqYP1udtkOc650d50pYviDdVWyUbyyIvMz68ZKC3englNRiWPlV+2nBD7aLSMbcwBvDxegMTuxPl+dfBtHn172tKXuny7s5AOWsxFppQMT5B+r3R9utQplTdGrXm5behNYukDc4WEPZqezCiYf8Pyq4CSS9Q9Z/0tVSBVP+kAHb1Q3MkIxfsVsQoB3t25kImSBZ83ltNQHstks0/DlIOh+aDYYMbpTQoWBf/Zmn+hpsLxCGsqI2OynrM9R5hjaZiPrFshV1DItGcmXlPWWSy2JrfNGbXB1Ua2tn5s3bU/TnbGTNzurKEIqsvYsCzRY/NSobhY0s8GKKiUBbv+Dhnt2Y0v2c8+kGgfRh/2JQ1ycehlQUSBVmwkuByHx5rXi/Tgkv7+93slNM+3FyOe98cPtHDyFv3rFNi7traJFAIOf0UBFhDEzLov3H8qmKgIdQB7+iIFcmRdcRAvTb1j6aDVg+NBWC;4:oPLqnhkvkJAdWWRvD7JS3/7/zrVFz2miKfgGdlBpClCUjwBilhrihkRvCRXwo7b5iAi1trlpUjiasSY4OkPRvh93Hh6MuP1WZvoBmJyzMEy0CVPD/kRWRo1K3WFB4xpIRGWhhI9i5noBCVFESO5Kajv5EdYUaKrkxCOM9NZP/DMMVOtlCM29ENnprojQkE/PfDplnEx4NLOEmBpOZDVcN59zoaaQ1iYLjmhMRjp5fDa742KDoMv3LO3dFc4qKmE4TV+FKEa7xIPnJVWHFoej/w==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714E92BA2E28E564067EA97832E0@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(6116002)(53936002)(2906002)(1706002)(31686004)(8676002)(2870700001)(81156014)(81166006)(8936002)(478600001)(6666003)(65826007)(93886005)(72206003)(36756003)(5660300001)(50466002)(68736007)(6246003)(486006)(6486002)(65806001)(25786009)(4326008)(39060400002)(229853002)(52116002)(105586002)(106356001)(2486003)(52146003)(97736004)(46003)(23676004)(64126003)(305945005)(76176011)(52396003)(386003)(53546011)(65956001)(16526019)(67846002)(316002)(476003)(2616005)(54906003)(7736002)(110136005)(11346002)(86362001)(47776003)(58126008)(446003)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOmV0MWduMUVGd3VIcVNCSmdHZnhLMkZXeG5D?=
 =?utf-8?B?eUsvRytidFVoY1ZHdXYzOXJVQTdlT1dYMFBCdEljOEM3Uk5HdkdFOWY1T0ZG?=
 =?utf-8?B?WEVSM2U3ZWFyS3U0aXlyd3VVWmFya05kdE8vU1dBU2JGV0V2MlMzMVFDWjc4?=
 =?utf-8?B?NC80bnkzaDNWTG5UZ3QybURSVVJkY21kMVRHNTlMZ3ZSWGFzSWxjR2ZPWDF5?=
 =?utf-8?B?aHVUZVhlRVRQMVlOTThkcjBCczEySHIreUF5NmRWWHRobjkzQnoyZDRna1A2?=
 =?utf-8?B?WlAwaHJHb2NUSytrd0dKUkF2bkpyMEZNT2tJbUJZdE9MS3U4a3hGZEtQMFpL?=
 =?utf-8?B?Nmg4TzZEU0RMQ0EzbTdYdGU5d2J6bGZ4KzhacmpKWXMxSzRvZ0dYWUFFV0hJ?=
 =?utf-8?B?RTNSbEorNUNzb0F2cng4QzBrRUZDUjZlKzZnR3QvYkNhNHJCWVVqZWZsS1pE?=
 =?utf-8?B?azF5THV4OEdyNUZmb05HTWR2RWtzc0tPNm85dTY4Q1BrSGR5OUNWK2pBcGhi?=
 =?utf-8?B?Tno4WUNhaWdTSWZQV05ZelJmSjBhbm91cEl1bzBld3NLb1l6bmNWMXBReWw0?=
 =?utf-8?B?TGdvdUhDWEtQbzRXSDZkNVJ4Nk9WMitNS2srSW4wZktmRHJTdW1VajVNZHpa?=
 =?utf-8?B?WGQwK3ZqVzhiYnc4K0FDK0tHbFk1ZzNyWlNiTnJVckF1MUNkNDNEY0pZamVV?=
 =?utf-8?B?TEhkZVNEQmdyemJCVWtuZjdlS1c1cVFXSDBWRE01Z3g4ZTFYeFRaRW9rOXlj?=
 =?utf-8?B?cmhmY0Vuc2I4endCcVBIRWV5RXFYZ2F1bUpLZG0wTDRjcFRYNUpBeUViYWFF?=
 =?utf-8?B?WmhCYks1YXNmeDVLeTB2ZVR6NlNkcFU3bXNLSEpPZTRqbldCc2Q5dHVudGNL?=
 =?utf-8?B?dHpQYU15YmNHRlEySnlRRFBKWWR3Mk9vOTNBUVlJTzNyK0pQa1pqYzRYdWZX?=
 =?utf-8?B?VzZDT3NTdFpHZ1pOc1dzSjZkKytZTWJteHdwMnlBc1luVVd6TGZnbFp5UEta?=
 =?utf-8?B?RlZHRmNKMGVSRlJ1V3hSMHJ1cmtWaHJxeDd5WjJRZHd6WHYwVTFPRTFreHJa?=
 =?utf-8?B?ckRjQU1YTU1uUUQ3N0lWUHRBVmFXVmJSNnVxRkNQOW42eHByV0x5RDg2Yzds?=
 =?utf-8?B?N2JXR1FJZDZjUTh0L09EVHdQWEZxR3o5dVE3NzI5NjVuTThjTFlKdnlKdWZZ?=
 =?utf-8?B?L1h5dzBoSEVSZmdaMkNvVVdGQ3R1YjQyK2xLUlFrOWZJUTM5cWprT01rYVpP?=
 =?utf-8?B?Tk9XcmwyMTNvQUF6YjdkdUlGSlFjalYzdit5Q2o3ano0MzJsZVI3eTNvTTVy?=
 =?utf-8?B?eVpiSis4aHpwMzFtbUV6TVp5UXZYVXRJcHlDMkVjbytVaC90cFFMM3lRbW42?=
 =?utf-8?B?QlNUeXlObERydStPbUZJU0xTWmFRa2p3UHpMN3pmMUFzWnk5Q3BJMHZ5RHlz?=
 =?utf-8?B?OTZjVHQ5NCtyS0RlcytyZVRZUVVPL1o5T3FPZ1ZESjd4eXIyTDVvdXl3cU1h?=
 =?utf-8?B?UVlOMTRIT2lueVh1endtSlBGNDRxQ1ZhVGRXWHVuVi8vZmNkSXJEc2I2UmlJ?=
 =?utf-8?B?VnZ0ZXJ5U0xTRDVnc0pQdHFhbFNRWWNQcVZybm9uY0lNNnVOWUtqU1pneTNt?=
 =?utf-8?B?MDM3QzVFL2N5QWxTaldkZEdpaE1SYnQxZmZsendPc0ZJM3N6ZFZlUTI5SHNL?=
 =?utf-8?B?UHlxYjZyeS9OTnQrTlhvL3hVRCtCbEdUS1lFamJRQ1FPTEE5UFZRUnUxN2dP?=
 =?utf-8?B?UHdwTUk5TCs4d0FtWjlpYU4vZzNDS1Q5aDRiRmJsbGFXa3lhY3BvM3BOeEt2?=
 =?utf-8?B?VjZwajlyeVpndDZTMVZuRlk1TnlkYUdaL21DcXBJUWt3Qk5pbnAzSUUrOFh5?=
 =?utf-8?B?SElMZlhEc0pzdnBwdDNqMXQ4UmNzcTJYYk9BOVd1bFFYbXd0UTBxc2l5WUxV?=
 =?utf-8?B?S3lKZGFRS0pnPT0=?=
X-Microsoft-Antispam-Message-Info: RXWc93l6MAdnsO+6OEQPT3JSn2qMkq1ActnIijC7yVGTcUFrIOmracffdemkEtYhxp1pqkNwDFeoouAmUju0e/U/d5Dy7nxTsZ2MHzP+OsjEGrkqMrL8f4lvfSv/KqON677kXxySgUjrpl+dv9EYiS3VS5V5kA2DTOWOJWSFHLNEMRrIE/77eHfp9/eUdk/oKj7jgK6WBYct45OhUdMVVNLibspou6sPXivc+5ZwyP1sjUMduiIbYRosothpDv6Q29IRzyVh1JjJQqHKkI4BlLGKbPGjDOpX2xUqB9/JoXgKm9BgXMho5Sx6RQbjcwN2nJVqKfXp0aIgNLx+V4kBjM/8xQTZlhIGncyXsRgMMrw=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:RT8T+ZsH7eTDMfqMX/FX5nzBqrgttPQ77xtH1fT38qxzy17mGuqz8UMXA6aDC/LqUQjJhe1B01tq+NEr+BxxVpl6Ab3uWUJ3WRCg9bxKqIyihzrCyfJ74vWlso/ju+uAW1OVD6NDcEaWvCwnXv7RGfJLpDFgvALbis+N4aBw6hOoVrTw23wcaulGsr9rzuai9BiIQSK1G+XHPCf7IGjznWIs/o/YyzJG2FlbfivA0jaP0N82DdEIp8wt6NI9xlOAm+7euNARnSTf4ZVc5vtKMhVae/bBEI4h061BtpV+bf4ATyXx4UqPhMyKJcWm7jRBEQfzA7CmDDho13W7TfjhbF7CLWoQ389wbiFv4UxLvtY3gnPt+b6XimAGvIrs8QTuI6JOvzXQ4F2fCzQDk9Uedh/31IfWvjbgFap+Z9ky5lVkujcc3FdjSdGDAvwlLXjBPEHXokkdECYOQdrUzBtE3g==;5:Coa5x26xRT/2QJcMx/25u7jKP64wjoU8rSug+NJ0EIXBNIDf6P1S3+PeuOn83Y3UQRixioW/OFZauBxq4vzbinPDEBRjduRw1zawgrxQ72D4Y3qFN2Qvj9MNjZ/QlJIUJN3DWWPL+Z8qDbP3B//iyJJb56l+VWnnz4PCn/77N2g=;7:1oRuzXx0bmuW7mZEDCDjMicseWpjE8FkUts7j7pt8cOIf53xXLi8SOGbi5wEKCeeYaBDTGgr8wSdp6r8Xhzx1zrnNOwcwaAZ7ni5dP8WmhcXwYJse3MD81XSIe+zvDFbiy0pk9uBQZLKzvdbALyOqjiEOB0egHmVEbTSYLZBUogJ68/rlRYyEKazSMveS50I3O6VJWfnimBlKhYD4h1H9vgqN7f5eQyQPdPtrh/C3Vkr0WNgE7iqmSNiASeoKXGL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:pTr+pbn1nGcjaGv4IGLC2VC13b4Cj/hmWIvjjJVRCr+1eQUYZt0a9UqykrxrrxcSyBHhRVkHqZxGUbjOoo9tZdnniYzvAiENkowDNukORpSvrWqj/xKch902H+v0P5+tROFspnmXD5+dyux/SbGTNYJSRxGp895RCZPavnfhz81Ythl9At56KFmKHtk2HwnLpYcKUFjITu7oBdjIDwz3QKFsjrsjlK3IF5u3n2XlTWbrEFvL6Sq3BoLP7X9kvPbw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 06:46:19.2879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90662a5-72d1-46c4-7179-08d5f6b154f1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.07.2018 um 22:14 schrieb Alex Deucher:
> On Mon, Jul 30, 2018 at 5:55 AM, Michel Dänzer <michel@daenzer.net> wrote:
>> On 2018-07-24 10:53 PM, Alex Deucher wrote:
>>> On Mon, Jul 23, 2018 at 12:32 PM, Gustavo A. R. Silva
>>> <gustavo@embeddedor.com> wrote:
>>>> idx can be indirectly controlled by user-space, hence leading to a
>>>> potential exploitation of the Spectre variant 1 vulnerability.
>>>>
>>>> This issue was detected with the help of Smatch:
>>>>
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:408 amdgpu_set_pp_force_state()
>>>> warn: potential spectre issue 'data.states'
>>>>
>>>> Fix this by sanitizing idx before using it to index data.states
>>> Is this actually necessary?  We already check that idx is valid a few
>>> lines before:
>>>          if (ret || idx >= ARRAY_SIZE(data.states)) {
>>>                          count = -EINVAL;
>>>                          goto fail;
>>>                  }
>> A Spectre attack would be based on idx ending up too large, but the CPU
>> speculatively executing the following code assuming idx <
>> ARRAY_SIZE(data.states), and extracting information from the incorrectly
>> speculated code via side channels.
>>
>> I'm not sure if that's actually possible in this case, but better safe
>> than sorry?
> Yeah, I'm not sure.  I guess this can't hurt.

Well is idx actually controlable by userspace in an IOCTL? I guess the 
answer is no.

On the other hand the array_index_nospec() macro makes the overhead 
absolute negligible.

So I agree that we should be better safe than sorry.

Christian.

>
> Alex

