Return-Path: <alexander.duyck@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525353608; cv=none;
        d=google.com; s=arc-20160816;
        b=b5jx2LQ79OCBmiCeYzRyu9vW0Uk5WQPIdq+fj0OLOlBDhELrC4uwxUBYxnHzx+1Hc7
         5sVxcotWjfB8Trmg0loB6AddcNPxviZuGcaBeNjJLUjitO7agVIx3W45JlytTxM5f5Dd
         amdNZKoyuQu6OhR59osEVuETAPd8zQrl9yrx+86vtgWrT0MlZN0Utrh52S1oOLc0ZZhg
         rqL8oS8TqieaGfZZB8e8Ip+eHgNtx0dqCA9NaB5A5G50P5S/pE+bfmEQv6FZWysh7cvv
         N+y7sVgID1r8baAbGIbmSP6Gw/NPJsWBafiLcUcDpaWKDcDSxDqPpc3UvMhYN2QfSoBu
         1UXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nsdGvjvAAsPmH8HW3yn2fqaR+LQ3M1tcdC+qIblcBLU=;
        b=AP4VqMabz49qCYqKMDf0T0OHL/iNA7PyIHXhWrAdSE2fRunw8AjuOW6Z2JVBGYy2Hg
         rvebMPR4Bm2n/iL5GP90g5spe8EicOvD7MYYcr6Ah0WVvzUbr/e8q+b/u/eVcd2l7Dvx
         ts+Cu0gsdhtzY73dbzRPmGDSKm9Npt5h54F/5ULcQEf2hlCnUe7CjdL8hur11sRDHskh
         mHiQFE9s+IfAY4KEa5LYSjdHziQEm7pUohSTy7f7fqc/E1FMbdN2tbqVZbpOWEN3hCI5
         6lYlhyhcg9mwgwTZ0g1zG6HyrVyKaDTa6NKi5CSEPbU3XOoeQeIATlpLS8Rng9BlgCKD
         jO8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rof04DiM;
       spf=pass (google.com: domain of alexander.duyck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.duyck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rof04DiM;
       spf=pass (google.com: domain of alexander.duyck@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=alexander.duyck@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqgBcC9ezmVKuX8yBzPVM1XwsTt16aZUPy7Bs+AEvpsUo79WniBWoFiKqhya+45MCTXESceNSKf+EuQVz7sZCA=
MIME-Version: 1.0
In-Reply-To: <20180503035931.22439-2-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com> <20180503035931.22439-2-pasha.tatashin@oracle.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 3 May 2018 06:20:07 -0700
Message-ID: <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ixgbe: release lock for the duration of ixgbe_suspend_close()
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	LKML <linux-kernel@vger.kernel.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan <intel-wired-lan@lists.osuosl.org>, Netdev <netdev@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599449185281657020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 8:59 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Currently, during device_shutdown() ixgbe holds rtnl_lock for the duration
> of lengthy ixgbe_close_suspend(). On machines with multiple ixgbe cards
> this lock prevents scaling if device_shutdown() function is multi-threaded.
>
> It is not necessary to hold this lock during ixgbe_close_suspend()
> as it is not held when ixgbe_close() is called also during shutdown but for
> kexec case.
>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index afadba99f7b8..e7875b58854b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6748,8 +6748,15 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
>         rtnl_lock();
>         netif_device_detach(netdev);
>
> -       if (netif_running(netdev))
> +       if (netif_running(netdev)) {
> +               /* Suspend takes a long time, device_shutdown may be
> +                * parallelized this function, so drop lock for the
> +                * duration of this call.
> +                */
> +               rtnl_unlock();
>                 ixgbe_close_suspend(adapter);
> +               rtnl_lock();
> +       }
>
>         ixgbe_clear_interrupt_scheme(adapter);
>         rtnl_unlock();

I'm not a fan of dropping the mutex while we go through
ixgbe_close_suspend. I'm concerned it will result in us having a
number of races on shutdown.

If anything, I think we would need to find a replacement for the mutex
that can operate at the per-netdev level if you are wanting to
parallelize this.

- Alex
