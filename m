Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeENSzv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:55:51 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:36603
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751515AbeENSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:55:48 -0400
X-YMail-OSG: i4_OKgMVM1mIRrau39lVN6Z4N9SywQvPXouXLntToVtsHZ65MrdhWE8PvOMiW1f
 eVoyzAWlY90PHMq5dv3Iogr8jqUP4Dd1O_BYLia36RjXQOLwT4_i6876Q4UOee_MAIAV7JaVny6U
 rrhGuWruW2NE9.ySf_AjvsZUT4P1KOKVu6hVYxB3gIsnqt98vlTGCNBUO3KRxYfzm9OdyPfoa8dZ
 XW95CcKHgiYGYNaVs5lNAnf6UAPhR1Qm3ujUgcLMtadG7lRyJM.rG4ue_wua3ZNpWVcoMaSLYopa
 aqyMoKe4MzEq5grnP8iY0PgONcgWFgonrOQeTbxCGPe9jDcQQ_luE_hp1OOsw1w1M1hlZ.0Pu5uV
 rRW2DlXj5whTAYWUp1qZ15ZGea5HDGs1h950oswnOwrAbbgSHi9nyHl9zAkoERIC.e2Hdk9vMRYK
 JoXmHZ.UAvkc_FLh5JHTa7exdZd6SgzLs.dQYLq8LDEm4kPCwHlWQ3HTUatpXqNiEyLJCGuEj_l1
 oivWk9ixGJXEooMomz2fzo526ZXeGw24R5_obakkt6one5pS3bHNFTJi9hD9PKFueBS1bVvDzzSN
 yxFUqeZtnVmwZbpS_lk2EC.cs799u9Bd04toFWHwBNU813MlwFoAWcUgUoE_vcZqLNsh_0l0KrH6
 u_JyxHbZmKXo57FGy2SNyuyQyfcSJ04y2
Subject: Re: [PATCH 20/23] LSM: Move common usercopy into
To: Stephen Smalley <sds@tycho.nsa.gov>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <cb3455a2-b957-8a9a-f056-35f97fe51e71@schaufler-ca.com>
 <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
 <992325e2-0f53-0b3d-ddd2-f4f8ba7ccf89@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0c6ec4e0-1562-8f30-09e9-9de0109b2cbc@schaufler-ca.com>
Date: Mon, 14 May 2018 11:55:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <992325e2-0f53-0b3d-ddd2-f4f8ba7ccf89@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2018 9:53 AM, Stephen Smalley wrote:
> On 05/14/2018 11:12 AM, Stephen Smalley wrote:
>> On 05/10/2018 08:55 PM, Casey Schaufler wrote:
>>> From: Casey Schaufler <casey@schaufler-ca.com>
>>> Date: Thu, 10 May 2018 15:54:25 -0700
>>> Subject: [PATCH 20/23] LSM: Move common usercopy into
>>>  security_getpeersec_stream
>>>
>>> The modules implementing hook for getpeersec_stream
>>> don't need to be duplicating the copy-to-user checks.
>>> Moving the user copy part into the infrastructure makes
>>> the security module code simpler and reduces the places
>>> where user copy code may go awry.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  include/linux/lsm_hooks.h  | 10 ++++------
>>>  include/linux/security.h   |  6 ++++--
>>>  security/apparmor/lsm.c    | 28 ++++++++++------------------
>>>  security/security.c        | 17 +++++++++++++++--
>>>  security/selinux/hooks.c   | 22 +++++++---------------
>>>  security/smack/smack_lsm.c | 19 ++++++++-----------
>>>  6 files changed, 48 insertions(+), 54 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 81504623afb4..84bc9ec01931 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -841,9 +841,8 @@
>>>   *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>>>   *	socket is associated with an ipsec SA.
>>>   *	@sock is the local socket.
>>> - *	@optval userspace memory where the security state is to be copied.
>>> - *	@optlen userspace int where the module should copy the actual length
>>> - *	of the security state.
>>> + *	@optval the security state.
>>> + *	@optlen the actual length of the security state.
>>>   *	@len as input is the maximum length to copy to userspace provided
>>>   *	by the caller.
>>>   *	Return 0 if all is well, otherwise, typical getsockopt return
>>> @@ -1674,9 +1673,8 @@ union security_list_options {
>>>  	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
>>>  	int (*socket_shutdown)(struct socket *sock, int how);
>>>  	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
>>> -	int (*socket_getpeersec_stream)(struct socket *sock,
>>> -					char __user *optval,
>>> -					int __user *optlen, unsigned int len);
>>> +	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
>>> +					int *optlen, unsigned int len);
>>>  	int (*socket_getpeersec_dgram)(struct socket *sock,
>>>  					struct sk_buff *skb,
>>>  					struct secids *secid);
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index ab70064c283f..712d138e0148 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -1369,8 +1369,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
>>>  	return 0;
>>>  }
>>>  
>>> -static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>> -						    int __user *optlen, unsigned len)
>>> +static inline int security_socket_getpeersec_stream(struct socket *sock,
>>> +						    char __user *optval,
>>> +						    int __user *optlen,
>>> +						    unsigned int len)
>>>  {
>>>  	return -ENOPROTOOPT;
>>>  }
>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>> index 90453dbb4fac..7444cfa689b3 100644
>>> --- a/security/apparmor/lsm.c
>>> +++ b/security/apparmor/lsm.c
>>> @@ -1017,10 +1017,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
>>>   *
>>>   * Note: for tcp only valid if using ipsec or cipso on lan
>>>   */
>>> -static int apparmor_socket_getpeersec_stream(struct socket *sock,
>>> -					     char __user *optval,
>>> -					     int __user *optlen,
>>> -					     unsigned int len)
>>> +static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
>>> +					     int *optlen, unsigned int len)
>>>  {
>>>  	char *name;
>>>  	int slen, error = 0;
>>> @@ -1037,22 +1035,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>>>  				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>>>  				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
>>>  	/* don't include terminating \0 in slen, it breaks some apps */
>>> -	if (slen < 0) {
>>> +	if (slen < 0)
>>>  		error = -ENOMEM;
>>> -	} else {
>>> -		if (slen > len) {
>>> -			error = -ERANGE;
>>> -		} else if (copy_to_user(optval, name, slen)) {
>>> -			error = -EFAULT;
>>> -			goto out;
>>> -		}
>>> -		if (put_user(slen, optlen))
>>> -			error = -EFAULT;
>>> -out:
>>> -		kfree(name);
>>> -
>>> +	else if (slen > len)
>>> +		error = -ERANGE;
>>> +	else {
>>> +		*optlen = slen;
>>> +		*optval = name;
>>>  	}
>>> -
>>> +	if (error)
>>> +		kfree(name);
>>>  done:
>>>  	end_current_label_crit_section(label);
>>>  
>>> diff --git a/security/security.c b/security/security.c
>>> index cbe1a497ec5a..6144ff52d862 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -1924,8 +1924,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>>  				      int __user *optlen, unsigned len)
>>>  {
>>> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>>> -				optval, optlen, len);
>>> +	char *tval = NULL;
>>> +	u32 tlen;
>>> +	int rc;
>>> +
>>> +	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>>> +			   &tval, &tlen, len);
>>> +	if (rc == 0) {
>>> +		tlen = strlen(tval) + 1;
>> Why are you recomputing tlen here from what the module provided, and further presuming it must be nul-terminated?
> Also, at least for SELinux, we copy out the length even when returning ERANGE, and libselinux uses that to realloc the buffer and try again.

All points acked and will be repaired. Thanks.
