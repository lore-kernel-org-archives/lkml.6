Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CE4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13602077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E1Vyd1Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13602077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeIGSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:13:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51416 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeIGSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:13:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w87DSxae035237;
        Fri, 7 Sep 2018 13:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4TWbFwzOncMsp2r1bWttnhgQjbBQg0jHS1YiM4Wplhs=;
 b=E1Vyd1Lxx2+iZeGFm3hE/0K2HDWYV4HfK1SA9LBTilkIsa7Y4SqbQFNAwAA+uJTcMs9T
 ffsX+dT9tQx6z9vng1PX8tkm6cQwn7goFd1e4VTaRL+m6WHw1i5Ndlws7uB+bNe8ZNvN
 7w7NSN4Xv6HaPAsWLYoNWZQH2AXanhRavqazuZIqsoV23c4VJG2f+Ktm6zo1Lqf8AEyS
 Fkl2pxsmV0K+KGxtHivONgaWw6q2qO+F+uvS9vVVsr9UwmjfMQ/HDRgQbCLO+37XWpQE
 1s7yFiylQnsVYZIR6g33eOYHx8TpPV1OoD9WLuqBFdGR2brO+tfKs73JRaevkl270bYw uw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m7j6u2nuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Sep 2018 13:32:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w87DW1Mh002023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Sep 2018 13:32:01 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w87DW0H2013615;
        Fri, 7 Sep 2018 13:32:00 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Sep 2018 06:32:00 -0700
Subject: Re: [PATCH v3] xen: avoid crash in disable_hotplug_cpu
To:     Olaf Hering <olaf@aepfle.de>, xen-devel@lists.xenproject.org
Cc:     Juergen Gross <jgross@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180907063023.16913-1-olaf@aepfle.de>
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
Message-ID: <26bef656-a1ec-8b81-98e2-ea723d095f03@oracle.com>
Date:   Fri, 7 Sep 2018 09:33:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907063023.16913-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9008 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809070137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:30 AM, Olaf Hering wrote:
> The command 'xl vcpu-set 0 0', issued in dom0, will crash dom0:
>
> BUG: unable to handle kernel NULL pointer dereference at 00000000000002d8
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 65 Comm: xenwatch Not tainted 4.19.0-rc2-1.ga9462db-default #1 openSUSE Tumbleweed (unreleased)
> Hardware name: Intel Corporation S5520UR/S5520UR, BIOS S5500.86B.01.00.0050.050620101605 05/06/2010
> RIP: e030:device_offline+0x9/0xb0
> Code: 77 24 00 e9 ce fe ff ff 48 8b 13 e9 68 ff ff ff 48 8b 13 e9 29 ff ff ff 48 8b 13 e9 ea fe ff ff 90 66 66 66 66 90 41 54 55 53 <f6> 87 d8 02 00 00 01 0f 85 88 00 00 00 48 c7 c2 20 09 60 81 31 f6
> RSP: e02b:ffffc90040f27e80 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8801f3800000 RSI: ffffc90040f27e70 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff820e47b3 R09: 0000000000000000
> R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffffff822e6d30
> R13: dead000000000200 R14: dead000000000100 R15: ffffffff8158b4e0
> FS:  00007ffa595158c0(0000) GS:ffff8801f39c0000(0000) knlGS:0000000000000000
> CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002d8 CR3: 00000001d9602000 CR4: 0000000000002660
> Call Trace:
>  handle_vcpu_hotplug_event+0xb5/0xc0
>  xenwatch_thread+0x80/0x140
>  ? wait_woken+0x80/0x80
>  kthread+0x112/0x130
>  ? kthread_create_worker_on_cpu+0x40/0x40
>  ret_from_fork+0x3a/0x50
>
> This happens because handle_vcpu_hotplug_event is called twice. In the
> first iteration cpu_present is still true, in the second iteration
> cpu_present is false which causes get_cpu_device to return NULL.
> In case of cpu#0, cpu_online is apparently always true.
>
> Fix this crash by checking if the cpu can be hotplugged, which is false
> for a cpu that was just removed.
>
> Also check if the cpu was actually offlined by device_remove, otherwise
> leave the cpu_present state as it is.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  drivers/xen/cpu_hotplug.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> index d4265c8ebb22..68f9f663da08 100644
> --- a/drivers/xen/cpu_hotplug.c
> +++ b/drivers/xen/cpu_hotplug.c
> @@ -19,11 +19,15 @@ static void enable_hotplug_cpu(int cpu)
>  
>  static void disable_hotplug_cpu(int cpu)
>  {
> +	if (!cpu_is_hotpluggable(cpu))
> +		return;
>  	if (cpu_online(cpu)) {
>  		lock_device_hotplug();
>  		device_offline(get_cpu_device(cpu));
>  		unlock_device_hotplug();
>  	}
> +	if (cpu_online(cpu))
> +		return;
>  	if (cpu_present(cpu))
>  		xen_arch_unregister_cpu(cpu);
>  


You don't get a warning in xen_init_lock_cpu() for CPU0?

Also, as a side question --- what is the purpose of 'xl vcpu-set <domid> 0'?

-boris
