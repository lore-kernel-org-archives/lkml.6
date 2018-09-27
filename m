Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB801C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1922170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="guYgW+T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1922170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeI1EIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:08:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeI1EIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:08:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RLe8h1162797;
        Thu, 27 Sep 2018 21:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PvuVbJENl8viSxwVlXKHnuKwq5+pcQhD5VG2iOb23Mg=;
 b=guYgW+T49FDXVUHa3wLFnu69IgVm2G7AzbZ7miEfMwhq3QXWqf4dPojHU+Pxz3m9ijG3
 ALW7yYRU79Rr+CcP2JnXgUha2LvOheJWwmWatbDdh4kXtJAgiWn+trxf3MapsvJA/2F0
 kjbK6A9+HbvoqbaIrdwm4j4+vDjR2/zh2LQ+sabynpPWyu4HyeH92IjkVCeygFPhzzi3
 1l5vn7bnXRTF4kpxk45c72MGuesDyvdkpLk/uN6fmM/GjmifZjZ1+xc2Rafz9RI/S9bL
 QwBG+cUie9e45D25lHg8HbKpfGv+6XDpf1cSCS/+Eg+a/5vWOIAW/cENlaltG3FPFOW7 xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mnd5tvrrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 21:47:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8RLlZJJ009781
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 21:47:36 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8RLlY18010152;
        Thu, 27 Sep 2018 21:47:35 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 14:47:34 -0700
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Jens Axboe <axboe@kernel.dk>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Juergen Gross <jgross@suse.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
 <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
 <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
 <b181cc24-16fc-ac94-24f8-1955efa6565d@kernel.dk>
 <04bc976c-9991-e24b-4994-55540b06f133@oracle.com>
 <4f53cd6f-0a73-ccdc-c816-1225aebd8d58@eikelenboom.it>
 <1d3d7e32-22d1-83aa-af0a-7ed6e628f5e5@kernel.dk>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 xsFNBFH8CgsBEAC0KiOi9siOvlXatK2xX99e/J3OvApoYWjieVQ9232Eb7GzCWrItCzP8FUV
 PQg8rMsSd0OzIvvjbEAvaWLlbs8wa3MtVLysHY/DfqRK9Zvr/RgrsYC6ukOB7igy2PGqZd+M
 MDnSmVzik0sPvB6xPV7QyFsykEgpnHbvdZAUy/vyys8xgT0PVYR5hyvhyf6VIfGuvqIsvJw5
 C8+P71CHI+U/IhsKrLrsiYHpAhQkw+Zvyeml6XSi5w4LXDbF+3oholKYCkPwxmGdK8MUIdkM
 d7iYdKqiP4W6FKQou/lC3jvOceGupEoDV9botSWEIIlKdtm6C4GfL45RD8V4B9iy24JHPlom
 woVWc0xBZboQguhauQqrBFooHO3roEeM1pxXjLUbDtH4t3SAI3gt4dpSyT3EvzhyNQVVIxj2
 FXnIChrYxR6S0ijSqUKO0cAduenhBrpYbz9qFcB/GyxD+ZWY7OgQKHUZMWapx5bHGQ8bUZz2
 SfjZwK+GETGhfkvNMf6zXbZkDq4kKB/ywaKvVPodS1Poa44+B9sxbUp1jMfFtlOJ3AYB0WDS
 Op3d7F2ry20CIf1Ifh0nIxkQPkTX7aX5rI92oZeu5u038dHUu/dO2EcuCjl1eDMGm5PLHDSP
 0QUw5xzk1Y8MG1JQ56PtqReO33inBXG63yTIikJmUXFTw6lLJwARAQABzTNCb3JpcyBPc3Ry
 b3Zza3kgKFdvcmspIDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT7CwXgEEwECACIFAlH8
 CgsCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEIredpCGysGyasEP/j5xApopUf4g
 9Fl3UxZuBx+oduuw3JHqgbGZ2siA3EA4bKwtKq8eT7ekpApn4c0HA8TWTDtgZtLSV5IdH+9z
 JimBDrhLkDI3Zsx2CafL4pMJvpUavhc5mEU8myp4dWCuIylHiWG65agvUeFZYK4P33fGqoaS
 VGx3tsQIAr7MsQxilMfRiTEoYH0WWthhE0YVQzV6kx4wj4yLGYPPBtFqnrapKKC8yFTpgjaK
 jImqWhU9CSUAXdNEs/oKVR1XlkDpMCFDl88vKAuJwugnixjbPFTVPyoC7+4Bm/FnL3iwlJVE
 qIGQRspt09r+datFzPqSbp5Fo/9m4JSvgtPp2X2+gIGgLPWp2ft1NXHHVWP19sPgEsEJXSr9
 tskM8ScxEkqAUuDs6+x/ISX8wa5Pvmo65drN+JWA8EqKOHQG6LUsUdJolFM2i4Z0k40BnFU/
 kjTARjrXW94LwokVy4x+ZYgImrnKWeKac6fMfMwH2aKpCQLlVxdO4qvJkv92SzZz4538az1T
 m+3ekJAimou89cXwXHCFb5WqJcyjDfdQF857vTn1z4qu7udYCuuV/4xDEhslUq1+GcNDjAhB
 nNYPzD+SvhWEsrjuXv+fDONdJtmLUpKs4Jtak3smGGhZsqpcNv8nQzUGDQZjuCSmDqW8vn2o
 hWwveNeRTkxh+2x1Qb3GT46uzsFNBFH8CgsBEADGC/yx5ctcLQlB9hbq7KNqCDyZNoYu1HAB
 Hal3MuxPfoGKObEktawQPQaSTB5vNlDxKihezLnlT/PKjcXC2R1OjSDinlu5XNGc6mnky03q
 yymUPyiMtWhBBftezTRxWRslPaFWlg/h/Y1iDuOcklhpr7K1h1jRPCrf1yIoxbIpDbffnuyz
 kuto4AahRvBU4Js4sU7f/btU+h+e0AcLVzIhTVPIz7PM+Gk2LNzZ3/on4dnEc/qd+ZZFlOQ4
 KDN/hPqlwA/YJsKzAPX51L6Vv344pqTm6Z0f9M7YALB/11FO2nBB7zw7HAUYqJeHutCwxm7i
 BDNt0g9fhviNcJzagqJ1R7aPjtjBoYvKkbwNu5sWDpQ4idnsnck4YT6ctzN4I+6lfkU8zMzC
 gM2R4qqUXmxFIS4Bee+gnJi0Pc3KcBYBZsDK44FtM//5Cp9DrxRQOh19kNHBlxkmEb8kL/pw
 XIDcEq8MXzPBbxwHKJ3QRWRe5jPNpf8HCjnZz0XyJV0/4M1JvOua7IZftOttQ6KnM4m6WNIZ
 2ydg7dBhDa6iv1oKdL7wdp/rCulVWn8R7+3cRK95SnWiJ0qKDlMbIN8oGMhHdin8cSRYdmHK
 kTnvSGJNlkis5a+048o0C6jI3LozQYD/W9wq7MvgChgVQw1iEOB4u/3FXDEGulRVko6xCBU4
 SQARAQABwsFfBBgBAgAJBQJR/AoLAhsMAAoJEIredpCGysGyfvMQAIywR6jTqix6/fL0Ip8G
 jpt3uk//QNxGJE3ZkUNLX6N786vnEJvc1beCu6EwqD1ezG9fJKMl7F3SEgpYaiKEcHfoKGdh
 30B3Hsq44vOoxR6zxw2B/giADjhmWTP5tWQ9548N4VhIZMYQMQCkdqaueSL+8asp8tBNP+TJ
 PAIIANYvJaD8xA7sYUXGTzOXDh2THWSvmEWWmzok8er/u6ZKdS1YmZkUy8cfzrll/9hiGCTj
 u3qcaOM6i/m4hqtvsI1cOORMVwjJF4+IkC5ZBoeRs/xW5zIBdSUoC8L+OCyj5JETWTt40+lu
 qoqAF/AEGsNZTrwHJYu9rbHH260C0KYCNqmxDdcROUqIzJdzDKOrDmebkEVnxVeLJBIhYZUd
 t3Iq9hdjpU50TA6sQ3mZxzBdfRgg+vaj2DsJqI5Xla9QGKD+xNT6v14cZuIMZzO7w0DoojM4
 ByrabFsOQxGvE0w9Dch2BDSI2Xyk1zjPKxG1VNBQVx3flH37QDWpL2zlJikW29Ws86PHdthh
 Fm5PY8YtX576DchSP6qJC57/eAAe/9ztZdVAdesQwGb9hZHJc75B+VNm4xrh/PJO6c1THqdQ
 19WVJ+7rDx3PhVncGlbAOiiiE3NOFPJ1OQYxPKtpBUukAlOTnkKE6QcA4zckFepUkfmBV1wM
 Jg6OxFYd01z+a+oL
Message-ID: <63d2a50f-c22e-1b99-8354-7feca9e089e5@oracle.com>
Date:   Thu, 27 Sep 2018 17:48:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1d3d7e32-22d1-83aa-af0a-7ed6e628f5e5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 5:37 PM, Jens Axboe wrote:
> On 9/27/18 2:33 PM, Sander Eikelenboom wrote:
>> On 27/09/18 21:06, Boris Ostrovsky wrote:
>>> On 9/27/18 2:56 PM, Jens Axboe wrote:
>>>> On 9/27/18 12:52 PM, Sander Eikelenboom wrote:
>>>>> On 27/09/18 16:26, Jens Axboe wrote:
>>>>>> On 9/27/18 1:12 AM, Juergen Gross wrote:
>>>>>>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>>>>>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>> added support for purging persistent grants when they are not in use. As
>>>>>>>> part of the purge, the grants were removed from the grant buffer, This
>>>>>>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>>>>>>> get_free_grant(). This can be observed even on an idle system, within
>>>>>>>> 20-30 minutes.
>>>>>>>>
>>>>>>>> We should keep the grants in the buffer when purging, and only free the
>>>>>>>> grant ref.
>>>>>>>>
>>>>>>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>>> Since Konrad is out, I'm going to queue this up for 4.19.
>>>>>>
>>>>> Hi Boris/Juergen.
>>>>>
>>>>> Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
>>>>> Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
>>> What do you mean by "rootFS is shuffled from under it's feet " ?
>> Assumption that block-front getting borked and either a kernel crash or rootfs becoming mounted readonly. Didn't (try) to check though.
>>
>>>>> and it gave these in dom0 dmesg:
>>>>>
>>>>> [ 9251.696090] xen-blkback: requesting a grant already in use
>>>>> [ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
>>>>> [ 9251.715781] xen-blkback: requesting a grant already in use
>>>>> [ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
>>>>> [ 9251.735698] xen-blkback: requesting a grant already in use
>>>>> [ 9251.745573] xen-blkback: trying to add a gref that's already in the tree
>>>>>
>>>>> The VM was a HVM with 4 vcpu's and 2 phy disks:
>>>>> xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>> xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>>
>>>>>
>>>>> Currently i have been running 4.19-rc5 with xen-next on top and commit
>>>>> a46b53672b2c reverted, for a couple of days. That seems to run stable
>>>>> for me (since it's a small box so i'm not hit by what a46b53672b2c
>>>>> tried to fix.
>>>>>
>>>>> If you can come up with a debug patch i can give that a spin tomorrow
>>>>> evening or in the weekend, so we are hopefully still in time for the
>>>>> 4.19 release.
>>>> At this late in the game, might make more sense to simply revert the
>>>> buggy commit.  Especially since what is currently out there doesn't fix
>>>> the issue for you.
>> Don't know if Boris or Juergen have a hunch about the issue, if not
>> perhaps a revert is the best.
> Anyone? Unless I hear otherwise, I'll revert the series tomorrow.

Juergen may have something to say by tomorrow, but from my perspective,
given that we are coming up on rc6 --- yes.

I looked at the patches again and didn't see anything obvious.

-boris


