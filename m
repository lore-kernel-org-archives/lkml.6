Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeBLCfi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 21:35:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeBLCfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 21:35:37 -0500
Subject: Re: [PATCH 3/9] nvme: change namespaces_mutext to namespaces_rwsem
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
 <4170b29e-693c-9c61-1b3b-716af09e44d0@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <9546c34d-36a1-1e5c-b833-d3b572ed8ea3@oracle.com>
Date: Mon, 12 Feb 2018 10:33:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4170b29e-693c-9c61-1b3b-716af09e44d0@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Thanks for your kindly response.
And sorry for my bad description. 

On 02/11/2018 07:17 PM, Sagi Grimberg wrote:
>> namespaces_mutext is used to synchronize the operations on ctrl
>> namespaces list. Most of the time, it is a read operation. It is
>> better to change it from mutex to rwsem.
>>
>> On the other hand, the namespaces mutex could introduce circular
>> dependency easily.
> 
> On the other hand of what?
> 
> Also, can you give an example of such?
> 

We have a lot of interface in nvme core that need to hold this 
namespace_mutex and looks like we will have more.
The mutex will trouble us in following scenario.

For example:

context A                        context B
nvme_xxx_xxx                     nvme_xxx_xxx
  -> hold namespace_mutex          -> try to require namespace_mutex
    -> sync context B

Keith's patch will incur this.
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015605.html

Because I add a interface that will hold namespace_mutex, so I add this patchset here.

Thanks
Jianchao
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=7MZaKEgFTQoH0JODWrGtapw7rGRwXzyRBi-OKlhNaTE&s=-L_YlxhBS6aEW6Gt5tI4bV67eWn4JdvW2Nh3HAZ111Y&e=
> 
