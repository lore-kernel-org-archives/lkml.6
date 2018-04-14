Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeDNR47 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 13:56:59 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:46180 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeDNR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 13:56:57 -0400
X-Google-Smtp-Source: AIpwx4/GhH/d1ngvouq17Hc8KOAqRbtDnFGDSSm5m4tyYNZA8ZNQfRsAX5Wwoi9l3iwBdsTUKYYmrQ==
To: Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
From: Laura Abbott <labbott@redhat.com>
Subject: Regression with 5dcd8400884c ("macsec: missing dev_put() on error in
 macsec_newlink()")
Message-ID: <9a3a84ff-1fd1-c063-0c50-a297d29a692b@redhat.com>
Date: Sat, 14 Apr 2018 10:56:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------BE353C688D35B3E385BEA9A3"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BE353C688D35B3E385BEA9A3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Fedora got a bug report of a regression when trying to remove the
the macsec module (https://bugzilla.redhat.com/show_bug.cgi?id=1566410).
I did a bisect and found

commit 5dcd8400884cc4a043a6d4617e042489e5d566a9
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed Mar 21 11:09:01 2018 +0300

     macsec: missing dev_put() on error in macsec_newlink()
     
     We moved the dev_hold(real_dev); call earlier in the function but forgot
     to update the error paths.
     
     Fixes: 0759e552bce7 ("macsec: fix negative refcnt on parent link")
     Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>

The script I used for testing based on the reporter is attached. It
looks like modprobe is stuck in the D state. Any idea?

Thanks,
Laura

--------------BE353C688D35B3E385BEA9A3
Content-Type: application/x-shellscript;
 name="mac-sec-setup.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mac-sec-setup.sh"

IyEvYmluL3NoCgoKIyBTZXR1cAptb2Rwcm9iZSBtYWNzZWMKaXAgbmV0bnMgYWRkIG1hY3Nl
Y19ucwppcCBsaW5rIGFkZCBtYWNzZWNfdmV0aCB0eXBlIHZldGggcGVlciBuYW1lIG1hY3Nl
Y192ZXRocAppcCBsaW5rIHNldCBtYWNzZWNfdmV0aHAgbmV0bnMgbWFjc2VjX25zCmlwIGxp
bmsgc2V0IG1hY3NlY192ZXRoIHVwCmlwIG5ldG5zIGV4ZWMgbWFjc2VjX25zIGlwIGxpbmsg
c2V0IG1hY3NlY192ZXRocCB1cAoKCmVjaG8gJ2VhcG9sX3ZlcnNpb249MycgPiAvdG1wL3dw
YV9zdXBwbGljYW50LmNvbmYKZWNobyAnYXBfc2Nhbj0wJyA+PiAvdG1wL3dwYV9zdXBwbGlj
YW50LmNvbmYKZWNobyAnbmV0d29yaz17JyA+PiAvdG1wL3dwYV9zdXBwbGljYW50LmNvbmYK
ZWNobyAnICBrZXlfbWdtdD1OT05FJyA+PiAvdG1wL3dwYV9zdXBwbGljYW50LmNvbmYKZWNo
byAnICBlYXBvbF9mbGFncz0wJyA+PiAvdG1wL3dwYV9zdXBwbGljYW50LmNvbmYKZWNobyAn
ICBtYWNzZWNfcG9saWN5PTEnID4+IC90bXAvd3BhX3N1cHBsaWNhbnQuY29uZgplY2hvICcg
IG1rYV9jYWs9MDAxMTIyMzM0NDU1NjY3Nzg4OTkwMDExMjIzMzQ0NTUnID4+IC90bXAvd3Bh
X3N1cHBsaWNhbnQuY29uZgplY2hvICcgIG1rYV9ja249NTU0NDMzMjIxMTAwOTk4ODc3NjY1
NTQ0MzMyMjExMDA1NTQ0MzMyMjExMDA5OTg4Nzc2NjU1NDQzMzIyMTEwMCcgPj4gL3RtcC93
cGFfc3VwcGxpY2FudC5jb25mCmVjaG8gJ30nID4+IC90bXAvd3BhX3N1cHBsaWNhbnQuY29u
ZgppcCBuZXRucyBleGVjIG1hY3NlY19ucyB3cGFfc3VwcGxpY2FudCAgLWMgL3RtcC93cGFf
c3VwcGxpY2FudC5jb25mIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC1pIG1hY3NlY192ZXRocCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtQiBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
RCBtYWNzZWNfbGludXggXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLVAgL3RtcC93cGFfc3VwcGxpY2FudF9tcy5waWQKCnNsZWVwIDYKaXAgbmV0bnMgZXhl
YyBtYWNzZWNfbnMgaXAgbGluayBzaG93IG1hY3NlYzAKaXAgbmV0bnMgZXhlYyBtYWNzZWNf
bnMgaXAgbGluayBzZXQgbWFjc2VjMCB1cAppcCBuZXRucyBleGVjIG1hY3NlY19ucyBpcCBh
ZGRyIGFkZCAxNzIuMTYuMTAuMS8yNCBkZXYgbWFjc2VjMAppcCBuZXRucyBleGVjIG1hY3Nl
Y19ucyBkbnNtYXNxIC0tcGlkLWZpbGU9L3RtcC9kbnNtYXNxX21zLnBpZCBcCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLS1kaGNwLXJhbmdlPTE3Mi4xNi4xMC4xMCwxNzIu
MTYuMTAuMjU0LDYwbSAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0taW50
ZXJmYWNlPW1hY3NlYzAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tYmlu
ZC1pbnRlcmZhY2VzCgojIFRlc3QKbm1jbGkgY29uIGFkZCB0eXBlIGV0aGVybmV0IGNvbi1u
YW1lIHRlc3QtbWFjc2VjLWJhc2UgaWZuYW1lIG1hY3NlY192ZXRoIGlwdjQubWV0aG9kIGRp
c2FibGVkIGlwdjYubWV0aG9kIGlnbm9yZQpubWNsaSBjb24gYWRkIHR5cGUgbWFjc2VjIGNv
bi1uYW1lIHRlc3QtbWFjc2VjIGlmbmFtZSBtYWNzZWMwIGF1dG9jb25uZWN0IG5vIG1hY3Nl
Yy5wYXJlbnQgbWFjc2VjX3ZldGggbWFjc2VjLm1vZGUgcHNrIG1hY3NlYy5ta2EtY2FrIDAw
MTEyMjMzNDQ1NTY2Nzc4ODk5MDAxMTIyMzM0NDU1IG1hY3NlYy5ta2EtY2tuIDU1NDQzMzIy
MTEwMDk5ODg3NzY2NTU0NDMzMjIxMTAwNTU0NDMzMjIxMTAwOTk4ODc3NjY1NTQ0MzMyMjEx
MDAKbm1jbGkgY29uIHVwIHRlc3QtbWFjc2VjLWJhc2UKbm1jbGkgY29uIHVwIHRlc3QtbWFj
c2VjCgpwaW5nIC1jIDIgMTcyLjE2LjEwLjEKCiMgQ2xlYW4gdXAKa2lsbCAkKGNhdCAvdG1w
L3dwYV9zdXBwbGljYW50X21zLnBpZCkKa2lsbCAkKGNhdCAvdG1wL2Ruc21hc3FfbXMucGlk
KQppcCBsaW5rIGRlbCBtYWNzZWNfdmV0aHAKaXAgbmV0bnMgZGVsZXRlIG1hY3NlY19ucwpu
bWNsaSBjb25uZWN0aW9uIGRlbGV0ZSB0ZXN0LW1hY3NlYyB0ZXN0LW1hY3NlYy1iYXNlCm1v
ZHByb2JlIC1yIG1hY3NlYwo=
--------------BE353C688D35B3E385BEA9A3--
