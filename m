Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965909AbeEIWev (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:34:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38290 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965118AbeEIWer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:34:47 -0400
X-Google-Smtp-Source: AB8JxZqZA9icyU4paplbmfa/xdpMDQNJpPyWOcByJHZmWsWgAQW8zOXHXENgXxCNidBcO4a6F1qRATmz3y8bVY9hpI4=
MIME-Version: 1.0
In-Reply-To: <1823373.ea0yBGqyI6@aspire.rjw.lan>
References: <56a8953c-d833-837c-57d5-fe758d4db02a@canonical.com> <1823373.ea0yBGqyI6@aspire.rjw.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 May 2018 00:34:46 +0200
X-Google-Sender-Auth: whcDD10rlBxZwCePTHZsCqWZaHo
Message-ID: <CAJZ5v0hUcwG1xQ3DacD91kjdZAjreA09a=1M-3vz7uoBL+La7Q@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Check device_may_wakeup() in pci_enable_wake()
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joseph Salisbury <joseph.salisbury@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        1745646@bugs.launchpad.net,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 12:18 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
> went too far and dropped the device_may_wakeup() check from
> pci_enable_wake() which causes wakeup to be enabled during system
> suspend, hibernation or shutdown for some PCI devices that are not
> allowed by user space to wake up the system from sleep (or power off).
>
> As a result of this excessive power is drawn by some of the affected
> systems while in sleep states or off.
>
> Restore the device_may_wakeup() check in pci_enable_wake(), but make
> sure that the PCI bus type's runtime suspend callback will not call
> device_may_wakeup() which is about system wakeup from sleep and not
> about device wakeup from runtime suspend.
>
> Fixes: 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
> Reported-by: Joseph Salisbury <joseph.salisbury@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, any concerns here?

> ---
>  drivers/pci/pci.c |   29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1910,7 +1910,7 @@ void pci_pme_active(struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_pme_active);
>
>  /**
> - * pci_enable_wake - enable PCI device as wakeup event source
> + * __pci_enable_wake - enable PCI device as wakeup event source
>   * @dev: PCI device affected
>   * @state: PCI state from which device will issue wakeup events
>   * @enable: True to enable event generation; false to disable
> @@ -1928,7 +1928,7 @@ EXPORT_SYMBOL(pci_pme_active);
>   * Error code depending on the platform is returned if both the platform and
>   * the native mechanism fail to enable the generation of wake-up events
>   */
> -int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
> +static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
>  {
>         int ret = 0;
>
> @@ -1969,6 +1969,23 @@ int pci_enable_wake(struct pci_dev *dev,
>
>         return ret;
>  }
> +
> +/**
> + * pci_enable_wake - change wakeup settings for a PCI device
> + * @pci_dev: Target device
> + * @state: PCI state from which device will issue wakeup events
> + * @enable: Whether or not to enable event generation
> + *
> + * If @enable is set, check device_may_wakeup() for the device before calling
> + * __pci_enable_wake() for it.
> + */
> +int pci_enable_wake(struct pci_dev *pci_dev, pci_power_t state, bool enable)
> +{
> +       if (enable && !device_may_wakeup(&pci_dev->dev))
> +               return -EINVAL;
> +
> +       return __pci_enable_wake(pci_dev, state, enable);
> +}
>  EXPORT_SYMBOL(pci_enable_wake);
>
>  /**
> @@ -1981,9 +1998,9 @@ EXPORT_SYMBOL(pci_enable_wake);
>   * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
>   * ordering constraints.
>   *
> - * This function only returns error code if the device is not capable of
> - * generating PME# from both D3_hot and D3_cold, and the platform is unable to
> - * enable wake-up power for it.
> + * This function only returns error code if the device is not allowed to wake
> + * up the system from sleep or it is not capable of generating PME# from both
> + * D3_hot and D3_cold and the platform is unable to enable wake-up power for it.
>   */
>  int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>  {
> @@ -2114,7 +2131,7 @@ int pci_finish_runtime_suspend(struct pc
>
>         dev->runtime_d3cold = target_state == PCI_D3cold;
>
> -       pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
> +       __pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
>
>         error = pci_set_power_state(dev, target_state);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
