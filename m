Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbeBEQ22 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:28:28 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40165 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeBEQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:28:21 -0500
X-Google-Smtp-Source: AH8x224Y0YESe5ZMW1cppPc74935x2w0Li21GSMAhHtbxFnfbmC36BBvZ6W6Yl77Tev3tIfPGszuKw==
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
To: Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org
Cc: stephen@networkplumber.org, w.bumiller@proxmox.com,
        ebiederm@xmission.com, jbenc@redhat.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, davem@davemloft.net
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
 <20180205155550.21432-2-christian.brauner@ubuntu.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <c82db104-eeb4-69ed-43c4-24f26c350aff@gmail.com>
Date: Mon, 5 Feb 2018 09:28:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205155550.21432-2-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/18 8:55 AM, Christian Brauner wrote:
> Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
> it is possible for userspace to send us requests with three different
> properties to identify a target network namespace. This affects at least
> RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
> network namespace which is confusing. For legacy reasons the kernel will
> pick the IFLA_NET_NS_PID property first and then look for the
> IFLA_NET_NS_FD property but there is no reason to extend this type of
> behavior to network namespace ids. The regression potential is quite
> minimal since the rtnetlink requests in question either won't allow
> IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
> support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> ChangeLog v1->v2:
> * return errno when the specified network namespace id is invalid
> * fill in struct netlink_ext_ack if the network namespace id is invalid
> * rename rtnl_ensure_unique_netns_attr() to rtnl_ensure_unique_netns() to
>   indicate that a request without any network namespace identifying attributes
>   is also considered valid.
> 
> ChangeLog v0->v1:
> * report a descriptive error to userspace via struct netlink_ext_ack
> * do not fail when multiple properties specifiy the same network namespace
> ---
>  net/core/rtnetlink.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

LGTM.

Acked-by: David Ahern <dsahern@gmail.com>
